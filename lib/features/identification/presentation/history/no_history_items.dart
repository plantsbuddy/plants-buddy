import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';

class NoHistoryItems extends StatelessWidget {
  const NoHistoryItems(this.type, {Key? key}) : super(key: key);

  final IdentificationType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            _icon,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String get _icon {
    switch (type) {
      case IdentificationType.plant:
        return custom_icons.plant;
      case IdentificationType.disease:
        return custom_icons.plantDisease;
      case IdentificationType.pest:
        return custom_icons.pest;
    }
  }

  String get _title {
    switch (type) {
      case IdentificationType.plant:
        return 'Identified Plants History';
      case IdentificationType.disease:
        return 'Identified Diseases History';
      case IdentificationType.pest:
        return 'Identified Pests History';
    }
  }

  String get _subtitle {
    switch (type) {
      case IdentificationType.plant:
        return 'You haven\'t performed a plant identification yet';
      case IdentificationType.disease:
        return 'You haven\'t performed a disease identification yet';
      case IdentificationType.pest:
        return 'You haven\'t performed a pest identification yet';
    }
  }
}
