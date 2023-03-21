import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/payment/domain/entities/payment_transaction.dart';
import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';
import 'package:http/http.dart' as http;

import '../../authentication/domain/entities/user.dart';

class PaymentServiceImpl implements PaymentService {
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization':
        'Bearer sk_test_51MnfyfJOIvc1seMOyvI5OGyZbyPLVnS4JwH90OTd7uYvcfxaQDom0DtfZSRzYbjeLLrpjA29Gh9Od5GntsPgJ2p200uddpURpD',
  };

  final CollectionReference _usersRef;
  final StreamController<Map<String, dynamic>> _paymentDetailsStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  PaymentServiceImpl() : _usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addCardDetails({
    required User user,
    required String cardholderName,
    required String cardNumber,
    required String cvc,
    required String expiryYear,
    required String expiryMonth,
  }) async {
    final addCardResponse = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_methods'),

      // 'Content-Type': 'application/json; charset=UTF-8',
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
      body: {
        'type': 'card',
        'card[exp_year]': expiryYear.toString(),
        'card[exp_month]': expiryMonth.toString(),
        'card[cvc]': cvc.toString(),
        'card[number]': cardNumber.replaceAll(" ", "").toString(),
      },
    );

    final Map<String, dynamic> addCardParsedResponse = jsonDecode(addCardResponse.body);

    if (!addCardParsedResponse.keys.contains('error')) {
      final customerId = await _createCustomer(user: user, paymentMethodId: addCardParsedResponse['id']);

      await _usersRef.doc(user.uid).update({
        'stripe_id': customerId,
        'stripe_card': cardNumber.toString(),
      });
    } else {
      throw InvalidCardNumberException();
    }
  }

  @override
  Future<Stream<Map<String, dynamic>>> getPaymentDetails() async {
    _usersRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transactions')
        .snapshots()
        .listen((transactionSnapshots) async {
      final userMap = await _usersRef.doc(FirebaseAuth.instance.currentUser!.uid).get();

      try {
        final stripeCustomerId = userMap.get('stripe_id') as String;
        final cardNumber = userMap.get('stripe_card') as String;

        final customerResponse = await http.get(
          Uri.parse('https://api.stripe.com/v1/customers/$stripeCustomerId'),
          headers: headers,
        );

        final customerResponseDecoded = jsonDecode(customerResponse.body);

        final List<PaymentTransaction> transactions = [];

        for (var transactionMap in transactionSnapshots.docs) {
          final transaction = PaymentTransaction(
            id: transactionMap.id,
            name: transactionMap.get('name') as String,
            time: transactionMap.get('time') as int,
            amount: transactionMap.get('amount') as int,
          );

          transactions.add(transaction);
        }

        _paymentDetailsStreamController.add({
          'balance': (customerResponseDecoded['balance'] as int) / 100,
          'card': cardNumber,
          'transactions': transactions,
        });
      } on StateError {
        _paymentDetailsStreamController.add({
          'balance': 0.0,
          'card': null,
          'transactions': <PaymentTransaction>[],
        });
      }
    });

    return _paymentDetailsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<List<Transaction>> getTransactionsHistory() async {
    throw UnimplementedError();
  }

  @override
  Future<void> performConsultationCharges({required String gardenerUid, required String botanistUid}) async {
    final gardenerMap = await _usersRef.doc(gardenerUid).get();
    final gardenerStripeCustomerId = gardenerMap['stripe_id'];

    final botanistMap = await _usersRef.doc(botanistUid).get();
    final botanistStripeCustomerId = botanistMap['stripe_id'];

    final consultationCharges = (botanistMap['consultation_charges'] as double).toInt();

    await http.post(
      Uri.parse('https://api.stripe.com/v1/customers/$gardenerStripeCustomerId/balance_transactions'),
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
      body: {
        'amount': (consultationCharges * -100).toString(),
        'currency': 'usd',
      },
    );

    await http.post(
      Uri.parse('https://api.stripe.com/v1/customers/$botanistStripeCustomerId/balance_transactions'),
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
      body: {
        'amount': (consultationCharges * 100).toString(),
        'currency': 'usd',
      },
    );

    await _usersRef.doc(botanistUid).collection('transactions').add({
      'name': gardenerMap.get('name'),
      'amount': consultationCharges * 100,
      'time': DateTime.now().millisecondsSinceEpoch,
    });

    await _usersRef.doc(gardenerUid).collection('transactions').add({
      'name': botanistMap.get('name'),
      'amount': consultationCharges * 100,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<String> _createCustomer({required User user, required String paymentMethodId}) async {
    final createCustomerResponse = await http.post(
      Uri.parse('https://api.stripe.com/v1/customers'),
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
      body: {
        'balance': "10000",
        'name': user.username,
        'description': '',
        'payment_method': paymentMethodId,
      },
    );

    final createCustomerParsedResponse = jsonDecode(createCustomerResponse.body);
    return createCustomerParsedResponse['id'] as String;
  }
}
