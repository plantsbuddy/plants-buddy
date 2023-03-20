import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({Key? key}) : super(key: key);

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cvvController;
  late final TextEditingController _cardholderNameController;
  late final TextEditingController _yearController;
  late final TextEditingController _monthController;

  String? cardNumberError;
  String? cvvError;
  String? cardholderNameError;
  String? yearError;
  String? monthError;

  @override
  void initState() {
    _cardNumberController = TextEditingController();
    _cvvController = TextEditingController();
    _cardholderNameController = TextEditingController();
    _yearController = TextEditingController();
    _monthController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              Row(
                children: [
                  Flexible(
                    flex: 8,
                    child: TextField(
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
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Theme.of(context).hintColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'\d|\s')),
                        CustomInputFormatter(inputLength: 16),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: cvvError,
                        hintText: 'CVV',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                    ),
                  ),
                ],
              ),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (false) {
                    } else {
                      Navigator.of(context).pop();
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
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cvvController.dispose();
    _cardholderNameController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }
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
