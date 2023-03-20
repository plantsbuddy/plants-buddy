import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/payment/presentation/add_card_sheet.dart';

import '../../authentication/logic/authentication_bloc.dart';
import '../logic/payment_bloc.dart';

class PaymentPageNoDetails extends StatelessWidget {
  const PaymentPageNoDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.currentUser!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  custom_icons.noCard,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'No Card Found',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Text(
                  'You have not added your card details for payment. Please click the button below to add a card.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
                  ).copyWith(
                    elevation: ButtonStyleButton.allOrNull(0.0),
                  ),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => BlocProvider<PaymentBloc>(
                      create: (context) => PaymentBloc(),
                      child: AddCardSheet(),
                    ),
                  ),
                  icon: Icon(Icons.add_card),
                  label: Text('Add Card'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
