import 'package:flutter/material.dart';

import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class ChatbotInitialView extends StatelessWidget {
  const ChatbotInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            custom_icons.chatbotHighRes,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Plantation Assistant',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            'You can ask me about details of plants, diseases, pests, or plantation suggestions',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
