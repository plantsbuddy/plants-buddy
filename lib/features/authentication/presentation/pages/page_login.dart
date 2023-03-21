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
                onPressed: () => context.read<AuthenticationBloc>().add(
                      AuthenticationLoginPressed(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    ),
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
