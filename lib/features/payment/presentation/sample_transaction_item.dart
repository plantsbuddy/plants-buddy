import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/authentication/domain/entities/user.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/payment/domain/entities/payment_transaction.dart';

class SampleTransactionItem extends StatelessWidget {
  const SampleTransactionItem(this.transaction, {Key? key}) : super(key: key);

  final PaymentTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final userIsBotanist = context.read<AuthenticationBloc>().state.currentUser!.userType == UserType.botanist;

    final color = userIsBotanist ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Row(
          children: [
            Text(
              '\$',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: color),
            ),
            Text(
              '5',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: color),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userIsBotanist ? 'Received from' : 'Paid to',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                ),
                Text(transaction.name, style: Theme.of(context).textTheme.titleSmall),
                Text(
                  'for consultation',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                transaction.formattedTime,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
