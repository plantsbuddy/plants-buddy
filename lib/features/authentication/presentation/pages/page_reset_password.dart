import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/authentication_bloc.dart';
import '../authentication_page_top_component.dart';

class PageResetPassword extends StatefulWidget {
  const PageResetPassword({Key? key}) : super(key: key);

  @override
  State<PageResetPassword> createState() => _PageResetPasswordState();
}

class _PageResetPasswordState extends State<PageResetPassword> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              AuthenticationPageTopComponent(state.pageIndex),
              Text(
                'Reset forgotten password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                child: TextField(
                  autofocus: false,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: state.resetEmailError,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () => context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationSendPasswordResetLinkPressed(_emailController.text)),
                  child: Text('Send reset link'))
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
