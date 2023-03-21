import '../../logic/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageSignupGardener extends StatefulWidget {
  const PageSignupGardener({Key? key}) : super(key: key);

  @override
  State<PageSignupGardener> createState() => _PageSignupGardenerState();
}

class _PageSignupGardenerState extends State<PageSignupGardener> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: state.signupNameError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: state.signupEmailError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'A verification link will be sent to this email',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: state.signupPasswordError,
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
              SizedBox(height: 5),
              Text(
                'Must be at least 8 characters long, contain at least one letter, alphabet, and special character',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                child: Text('SIGN UP'),
                onPressed: () => context.read<AuthenticationBloc>().add(
                      AuthenticationSignupGardenerPressed(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
