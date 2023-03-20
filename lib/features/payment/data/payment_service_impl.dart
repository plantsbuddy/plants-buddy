import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:plants_buddy/features/payment/domain/entities/payment_transaction.dart';
import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';
import 'package:http/http.dart' as http;

import '../../authentication/domain/entities/user.dart';

class PaymentServiceImpl implements PaymentService {
  final String secret = '';
  final CollectionReference _usersRef;
  final StreamController<Map<String, dynamic>> _paymentDetailsStreamController =
      StreamController<Map<String, dynamic>>();

  PaymentServiceImpl() : _usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addCardDetails({
    required User user,
    required String cardholderName,
    required int cardNumber,
    required int cvv,
    required int expiryYear,
    required int expiryMonth,
  }) async {
    final addCardResponse = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_methods'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Bearer sk_test_51MnfyfJOIvc1seMOyvI5OGyZbyPLVnS4JwH90OTd7uYvcfxaQDom0DtfZSRzYbjeLLrpjA29Gh9Od5GntsPgJ2p200uddpURpD',
      },
      body: jsonEncode(<String, dynamic>{
        'type': 'card',
        'card[exp_year]': expiryYear,
        'card[exp_month]': expiryMonth,
        'card[cvv]': cvv,
        'card[number]': cardNumber,
      }),
    );

    final addCardParsedResponse = jsonDecode(addCardResponse.body);

    final customerId = await _createCustomer(user: user, paymentMethodId: addCardParsedResponse['id']);

    await _usersRef.doc(user.uid).update({
      'stripe_id': customerId,
      'stripe_card': cardNumber,
    });
  }

  @override
  Future<Stream<Map<String, dynamic>>> getPaymentDetails() async {
    _usersRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transactions')
        .snapshots()
        .listen((transactionSnapshots) async {
      final user = await _usersRef.doc(FirebaseAuth.instance.currentUser!.uid).get();

      final stripeCustomerId = user.get('stripe_id') as String;
      final cardNumber = user.get('stripe_card') as String;

      final customerResponse = await http.get(
        Uri.parse('https://api.stripe.com/v1/customers/$stripeCustomerId'),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Bearer sk_test_51MnfyfJOIvc1seMOyvI5OGyZbyPLVnS4JwH90OTd7uYvcfxaQDom0DtfZSRzYbjeLLrpjA29Gh9Od5GntsPgJ2p200uddpURpD',
        },
      );

      final customerResponseDecoded = jsonDecode(customerResponse.body);

      final List<PaymentTransaction> transactions = [];

      for (var transactionMap in transactionSnapshots.docs) {
        final transaction = PaymentTransaction(
          id: transactionMap.id,
          botanistName: transactionMap.get('botanist_name'),
          time: transactionMap.get('time'),
          amount: transactionMap.get('amount'),
        );

        transactions.add(transaction);
      }

      _paymentDetailsStreamController.add({
        'balance': (customerResponseDecoded['balance'] as int) / 100,
        'card': cardNumber,
        'transactions': transactions,
      });
    });

    return _paymentDetailsStreamController.stream;
  }

  @override
  Future<List<Transaction>> getTransactionsHistory() async {
    throw UnimplementedError();
  }


  @override
  Future<void> performConsultationCharges({required String gardener, required String botanist}) async {
    // TODO: implement performConsultationCharges
    throw UnimplementedError();
  }

  Future<String> _createCustomer({required User user, required String paymentMethodId}) async {
    final createCustomerResponse = await http.post(
      Uri.parse('https://api.stripe.com/v1/customers'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Bearer sk_test_51MnfyfJOIvc1seMOyvI5OGyZbyPLVnS4JwH90OTd7uYvcfxaQDom0DtfZSRzYbjeLLrpjA29Gh9Od5GntsPgJ2p200uddpURpD',
      },
      body: jsonEncode(<String, dynamic>{
        'balance': 10000,
        'name': user.username,
        'description': '',
        'payment_method': paymentMethodId,
      }),
    );

    final createCustomerParsedResponse = jsonDecode(createCustomerResponse.body);
    return createCustomerParsedResponse['id'] as String;
  }
}
