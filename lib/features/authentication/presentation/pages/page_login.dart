import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/authentication/presentation/authentication_page_top_component.dart';

import '../../logic/authentication_bloc.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) => Navigator.of(context).pushNamed(routes.home),
      listenWhen: (previous, current) => current.userLoggedIn,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthenticationPageTopComponent(state.pageIndex),
              TextField(
                autofocus: false,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: state.loginEmailError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: state.loginPasswordError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.passwordHidden ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationPasswordVisibilityToggled()),
                  ),
                ),
                obscureText: state.passwordHidden,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Color(0xFF3F74B5)),
                  onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationChangePagePressed(index: 4)),
                  child: Text('Forgot password?'),
                ),
              ),
              ElevatedButton(
                child: Text('LOGIN'),
                onPressed: () async {
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
                              Text('Logging in...'),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  if (emailController.text.trim().isNotEmpty) {
                    final snapshots = await FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: emailController.text.trim())
                        .get();

                    if (snapshots.size != 0) {
                      final isBlocked = snapshots.docs.first.get('blocked') as bool;

                      if (isBlocked) {
                        Navigator.of(context).pop();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('You are blocked'),
                              content: Text(
                                  'You have been blocked by an admin from using the app, due to the violation of community guidelines of the app'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Okay'),
                                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        context.read<AuthenticationBloc>().add(
                              AuthenticationLoginPressed(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    }
                  } else {
                    Navigator.of(context).pop();

                    context.read<AuthenticationBloc>().add(
                          AuthenticationLoginPressed(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Color(0xFF3F74B5)),
                    onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationChangePagePressed(index: 1)),
                    child: Text('SIGNUP'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
