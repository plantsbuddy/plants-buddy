import 'package:flutter/material.dart';

import '../components/sample_botanist_item.dart';

class BotanistsPage extends StatelessWidget {
  const BotanistsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => SampleBotanistItem(),
      itemCount: 10,
    );
  }
}
