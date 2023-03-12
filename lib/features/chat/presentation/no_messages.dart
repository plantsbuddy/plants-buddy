import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import '../../authentication/domain/entities/user.dart';

class NoMessages extends StatelessWidget {
  const NoMessages(this.otherUser, {Key? key}) : super(key: key);

  final User otherUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            custom_icons.noMessages,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'No Messages',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'You have not sent any message to each other yet. Write a message and click the send button to send it to ${otherUser.username}',
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
