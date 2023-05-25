import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/payment/logic/payment_bloc.dart';

import '../../authentication/logic/authentication_bloc.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({Key? key}) : super(key: key);

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cvcController;
  late final TextEditingController _cardholderNameController;
  late final TextEditingController _yearController;
  late final TextEditingController _monthController;

  String? cardNumberError;
  String? cvcError;
  String? cardholderNameError;
  String? yearError;
  String? monthError;

  @override
  void initState() {
    _cardNumberController = TextEditingController();
    _cvcController = TextEditingController();
    _cardholderNameController = TextEditingController();
    _yearController = TextEditingController();
    _monthController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (_, state) {
        if (state.dialogShowing) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Adding card...'),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state.cardNumberError != null) {
          setState(() => cardNumberError = state.cardNumberError);
          Navigator.of(context).pop();
          // Future.delayed(const Duration(milliseconds: 100), () => Navigator.of(context).pop());
        } else {
          Navigator.of(context).pop();
          // Future.delayed(const Duration(milliseconds: 200), () => Navigator.of(context).pop());
        }
      },
      listenWhen: (previous, current) =>
          (previous.cardNumberError != current.cardNumberError) ||
          (previous.cardNumber != current.cardNumber) ||
          (previous.dialogShowing != current.dialogShowing),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Card',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Card number',
                    errorText: cardNumberError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.17),
                    prefixIcon: Icon(
                      Icons.credit_card,
                      color: Theme.of(context).hintColor,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'\d|\s')),
                    CustomInputFormatter(inputLength: 16),
                    LengthLimitingTextInputFormatter(22),
                  ],
                ),
                SizedBox(height: 15),
                TextField(
                    controller: _cvcController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: cvcError,
                      hintText: 'CVC',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.visibility_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                      fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.17),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                    ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: TextField(
                    controller: _cardholderNameController,
                    decoration: InputDecoration(
                      errorText: cardholderNameError,
                      hintText: 'Cardholder name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).hintColor,
                      ),
                      fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.17),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: yearError,
                      hintText: 'Expiry year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).hintColor,
                      ),
                      fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.17),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                    ]),
                SizedBox(height: 15),
                TextField(
                    controller: _monthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: monthError,
                      hintText: 'Expiry month',
                      prefixIcon: Icon(
                        Icons.calendar_view_month,
                        color: Theme.of(context).hintColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.17),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(2),
                    ]),
                SizedBox(height: 25),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final card = _cardNumberController.text;
                      final name = _cardholderNameController.text;
                      final cvc = _cvcController.text;
                      final expiryMonth = _monthController.text;
                      final expiryYear = _yearController.text;

                      const error = 'This field is required';

                      if (card.isEmpty) {
                        setState(() => cardNumberError = error);
                      } else if (name.isEmpty) {
                        setState(() => cardholderNameError = error);
                      } else if (cvc.isEmpty) {
                        setState(() => cvcError = error);
                      } else if (expiryMonth.isEmpty) {
                        setState(() => monthError = error);
                      } else if (expiryYear.isEmpty) {
                        setState(() => yearError = error);
                      } else {
                        setState(() {
                          cardNumberError = null;
                          cvcError = null;
                          cardholderNameError = null;
                          yearError = null;
                          monthError = null;
                        });
                        context.read<PaymentBloc>().add(PaymentAddCardPressed(
                            user: context.read<AuthenticationBloc>().state.currentUser!,
                            cardholderName: name,
                            cardNumber: card,
                            cvc: cvc,
                            expiryYear: expiryYear,
                            expiryMonth: expiryMonth));
                        // Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_card),
                        SizedBox(width: 20),
                        Text('Add Card'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// @override
// void dispose() {
//   _cardNumberController.dispose();
//   _cvcController.dispose();
//   _cardholderNameController.dispose();
//   _yearController.dispose();
//   _monthController.dispose();
//   super.dispose();
// }
}

class CustomInputFormatter extends TextInputFormatter {
  final int? inputLength;

  CustomInputFormatter({this.inputLength});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String left = oldValue.text.substring(0, min(oldValue.selection.start, newValue.selection.end));
    String right = oldValue.text.substring(oldValue.selection.end);
    String inserted = newValue.text.substring(left.length, newValue.selection.end);
    String modLeft = left.replaceAll(" ", "");
    String modRight = right.replaceAll(" ", "");
    String modInserted = inserted.replaceAll(" ", "");
    if (inputLength != null) {
      modInserted = modInserted.substring(0, min(inputLength! - modLeft.length - modRight.length, modInserted.length));
    }
    final regEx = RegExp(r'\d{1,4}');
    String updated =
        regEx.allMatches((modLeft + modInserted + modRight).toUpperCase()).map((e) => e.group(0)).join("  ");
    int cursorPosition = regEx.allMatches(modLeft + modInserted).map((e) => e.group(0)).join("  ").length;
    return TextEditingValue(text: updated, selection: TextSelection.collapsed(offset: cursorPosition));
  }
}
