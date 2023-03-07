import 'package:flutter/material.dart';
import 'package:plants_buddy/features/chat/presentation/sample_first_person_message.dart';
import 'package:plants_buddy/features/chat/presentation/write_a_message.dart';

import 'sample_first_person_file.dart';
import 'sample_second_person_file.dart';
import 'sample_second_person_message.dart';

class ChatInterface extends StatelessWidget {
  const ChatInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/3/3a/John_G._Dow.jpg',
                height: 40,
                fit: BoxFit.cover,
                width: 40,
              ),
            ),
            SizedBox(width: 20),
            Text('Mohsin Ismail'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return index % 4 == 0 ? SampleSecondPersonMessage() : SampleFirstPersonFile();
              },
              itemCount: 20,
            ),
          ),
          WriteAMessage(),
        ],
      ),
    );
  }
}
