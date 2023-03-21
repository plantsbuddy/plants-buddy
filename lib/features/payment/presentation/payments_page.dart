import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/payment/logic/payment_bloc.dart';

import 'payment_page_no_details.dart';
import 'payment_page_with_details.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.currentUser!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            switch (state.status) {
              case PaymentStatus.loading:
                return Center(child: CircularProgressIndicator());
              case PaymentStatus.loaded:
                return Column(
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
                    state.cardNumber == null ? PaymentPageNoDetails() : PaymentPageWithDetails(),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
