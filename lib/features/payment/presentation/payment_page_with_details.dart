import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/payment/presentation/add_card_sheet.dart';

import '../../authentication/logic/authentication_bloc.dart';
import '../logic/payment_bloc.dart';
import 'sample_transaction_item.dart';

class PaymentPageWithDetails extends StatelessWidget {
  const PaymentPageWithDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PaymentBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.85),
                Theme.of(context).colorScheme.surfaceTint.withOpacity(0.8),
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$ ${state.balance}',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'Account Balance',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(height: 10),
              Text(
                state.cardNumber!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Transaction History',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(height: 20),
        state.transactions.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return SampleTransactionItem(state.transactions[index]);
                },
                itemCount: state.transactions.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              )
            : Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Icon(Icons.money_off),
                    SizedBox(height: 10),
                    Text('No transactions yet'),
                  ],
                ),
              ),
      ],
    );
  }
}
