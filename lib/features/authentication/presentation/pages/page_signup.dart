import 'package:plants_buddy/core/utils/strings.dart';
import 'package:plants_buddy/features/authentication/presentation/pages/page_signup_gardener.dart';
import '../../logic/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication_page_top_component.dart';
import 'page_signup_botanist.dart';

class PageSignup extends StatefulWidget {
  const PageSignup({Key? key}) : super(key: key);

  @override
  State<PageSignup> createState() => _PageSignupState();
}

class _PageSignupState extends State<PageSignup> {
  bool gardenerSelected = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                AuthenticationPageTopComponent(state.pageIndex),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => gardenerSelected = true),
                      child: Chip(
                        label: Text('Gardener'),
                        backgroundColor: gardenerSelected ? Theme.of(context).colorScheme.inversePrimary : null,
                        side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => setState(() => gardenerSelected = false),
                      child: Chip(
                        label: Text('Botanist'),
                        backgroundColor: !gardenerSelected ? Theme.of(context).colorScheme.inversePrimary : null,
                        side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                      ),
                    ),
                  ],
                ),
                gardenerSelected ? PageSignupGardener() : PageSignupBotanist(),
              ],
            ),
          ),
        );
      },
    );
  }
}
