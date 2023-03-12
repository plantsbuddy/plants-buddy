import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import '../../authentication/domain/entities/user.dart';

class NoChats extends StatelessWidget {
  const NoChats(this.currentUser, {Key? key}) : super(key: key);

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            custom_icons.noChats,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'No Chats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'You haven\'t started any conversation with any ${currentUser.userType.toString().split('.').last} yet',
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
}
