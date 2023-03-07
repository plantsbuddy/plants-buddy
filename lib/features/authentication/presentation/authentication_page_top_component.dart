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

class AuthenticationPageTopComponent extends StatelessWidget {
  const AuthenticationPageTopComponent(this.selectedPage, {Key? key}) : super(key: key);

  final int selectedPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        selectedPage == 1 || selectedPage == 4
            ? Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationChangePagePressed()),
                ),
              )
            : SizedBox(height: 48),
        SvgPicture.asset(
          custom_icons.plantsBuddy,
          width: 140,
          height: 140,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 40),
          child: Text(
            strings.plantsBuddy,
            style: Theme.of(context).titleText,
          ),
        ),
      ],
    );
  }
}
