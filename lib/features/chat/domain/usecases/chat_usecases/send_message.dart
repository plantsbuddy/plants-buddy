import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

class SendMessage {
  final ChatService _chatService;

  SendMessage(this._chatService);

  Future<void> call(Message message) async {
    // final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    // log('b');
    // final sender = currentUserUid == conversation.currentUser.uid ? conversation.currentUser : conversation.otherUser;
    // log('c');
    // final receiver = sender == conversation.currentUser ? conversation.otherUser : conversation.currentUser;
    //
    // log(sender.toString());
    // log(receiver.toString());
    //
    // final message = Message(
    //   body: body.trim(),
    //   timestamp: DateTime.now().millisecondsSinceEpoch,
    //   sender: sender,
    //   receiver: receiver,
    // );

    await _chatService.sendMessage(message);
  }
}
