import 'package:flutter/material.dart';

extension CustomTextStyles on ThemeData {
  TextStyle get titleText => TextStyle(
        fontSize: 20,
        color: colorScheme.onBackground,
        fontWeight: FontWeight.bold,
      );

  TextStyle get smallText => TextStyle(
        fontSize: 12,
        color: dividerColor,
      );

  TextStyle get sectionTitleText => TextStyle(
        fontSize: 14,
        color: colorScheme.secondary,
        fontWeight: FontWeight.bold,
      );
}
