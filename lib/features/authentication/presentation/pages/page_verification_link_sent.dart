import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';

import '../authentication_page_top_component.dart';

class PageVerificationLinkSent extends StatelessWidget {
  const PageVerificationLinkSent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          AuthenticationPageTopComponent(2),
          Text(
            'Verification Link sent',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
            child: Text(
              'Please click the verification link sent to your email, in order to verify your email.',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
          ElevatedButton(onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationOpenEmailAppPressed()), child: Text('Open email app'))
        ],
      ),
    );
  }
}
