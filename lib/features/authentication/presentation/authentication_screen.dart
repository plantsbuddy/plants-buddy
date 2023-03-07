import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/themes/text_styles.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/core/utils/strings.dart' as strings;
import 'package:plants_buddy/features/authentication/presentation/pages/page_email_not_verified.dart';
import '../logic/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pages/page_login.dart';
import 'pages/page_password_reset_link_sent.dart';
import 'pages/page_reset_password.dart';
import 'pages/page_signup.dart';
import 'pages/page_signup_gardener.dart';
import 'pages/page_verification_link_sent.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state.dialogShowing) {
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
                          Text(state.dialogText!),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              Future.delayed(const Duration(milliseconds: 200), () => Navigator.of(context).pop());
            }
          },
          listenWhen: (previous, current) => previous.dialogShowing != current.dialogShowing,
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              _pageController.animateToPage(
                state.pageIndex,
                duration: Duration(milliseconds: 250),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            listenWhen: (previous, current) => previous.pageIndex != current.pageIndex,
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () async {
                 // int? index = _determineBackPage(state.pageIndex);

                  if (state.pageIndex == 0) {
                    return true;
                  } else {
                    context.read<AuthenticationBloc>().add(AuthenticationChangePagePressed());
                    return false;
                  }
                },
                child: PageView(
                  controller: _pageController,
                  children: [
                    PageLogin(),
                    PageSignup(),
                    PageVerificationLinkSent(),
                    PageEmailNotVerified(),
                    PageResetPassword(),
                    PagePasswordResetLinkSent(),
                  ],
                  physics: NeverScrollableScrollPhysics(),
                ),
              );
            },
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


}
