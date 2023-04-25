import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../logic/chatbot_bloc.dart';

class AskAQuery extends StatefulWidget {
  const AskAQuery({Key? key}) : super(key: key);

  @override
  State<AskAQuery> createState() => _WriteAMessage();
}

class _WriteAMessage extends State<AskAQuery> {
  final SpeechToText _speechToText = SpeechToText();
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      //color: Colors.blueGrey[100], //Colors.black.withAlpha(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.grey[200]),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Ask a query...',
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  isDense: true,
                ),
                controller: _controller,
              ),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 40,
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please write a query...'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                } else {
                  context.read<ChatbotBloc>().add(ChatbotQuerySubmitPressed(_controller.text));
                  _controller.clear();
                }
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 16,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                backgroundColor: Theme.of(context).colorScheme.secondary, // <-- Button color
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
            child: Icon(
              _speechToText.isNotListening ? Icons.mic : Icons.stop,
              color: Colors.white,
              size: 20,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              backgroundColor: Theme.of(context).colorScheme.secondary, // <-- Button color
            ),
          ),
        ],
      ),
    );
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _controller.text = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
