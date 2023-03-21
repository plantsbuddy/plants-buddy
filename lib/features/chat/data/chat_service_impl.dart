import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

import '../../authentication/domain/entities/user.dart';

class ChatServiceImpl implements ChatService {
  final CollectionReference _conversationsRef;
  final CollectionReference _usersRef;

  late Conversation _currentConversation;

  final _messagesStreamController = StreamController<List<Message>>.broadcast();
  final _conversationsStreamController = StreamController<List<Conversation>>.broadcast();

  ChatServiceImpl()
      : _conversationsRef = FirebaseFirestore.instance.collection('conversations'),
        _usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<Stream<List<Conversation>>> getConversations(User currentUser) async {
    _conversationsRef
        .where('recipients', arrayContains: currentUser.uid)
        .snapshots()
        .listen((conversationsSnapshots) async {
      final List<Conversation> conversations = [];

      for (var conversationMap in conversationsSnapshots.docs) {
        final recipients = conversationMap.get('recipients') as List<dynamic>;
        final otherUserUid = (recipients..remove(currentUser.uid)).first;

        final otherUserMap = await _usersRef.doc(otherUserUid).get();

        final otherUser = User(
          uid: otherUserMap.id,
          username: otherUserMap.get('name'),
          email: otherUserMap.get('email'),
          userType: currentUser.userType == UserType.gardener ? UserType.botanist : UserType.gardener,
          profilePicture: otherUserMap.get('pictureUrl'),
        );

        final messagesRef = _conversationsRef.doc(conversationMap.id).collection('messages');

        final unreadMessages = await messagesRef
            .where('read', isEqualTo: false)
            .where('receiver', isEqualTo: currentUser.uid)
            //.orderBy('timestamp')
            .get();

        Message? lastMessage;

        try {
          final lastMessageMap = await messagesRef.doc(conversationMap.get('last_message') as String).get();

          final senderUid = lastMessageMap.get('sender') as String;

          lastMessage = Message(
            id: lastMessageMap.id,
            body: lastMessageMap.get('body') as String,
            timestamp: lastMessageMap.get('timestamp') as int,
            sender: senderUid == currentUser.uid ? currentUser : otherUser,
            receiver: senderUid == currentUser.uid ? otherUser : currentUser,
          );
        } on StateError {
          final messages =
              await _conversationsRef.doc(conversationMap.id).collection('messages').orderBy('timestamp').get();

          if (messages.docs.isNotEmpty) {
            final senderUid = messages.docs.last.get('sender') as String;

            lastMessage = Message(
              id: messages.docs.last.id,
              body: messages.docs.last.get('body') as String,
              timestamp: messages.docs.last.get('timestamp') as int,
              sender: senderUid == currentUser.uid ? currentUser : otherUser,
              receiver: senderUid == currentUser.uid ? otherUser : currentUser,
            );
          }
        }

        final conversation = Conversation(
          id: conversationMap.id,
          currentUser: currentUser,
          otherUser: otherUser,
          lastMessage: lastMessage,
          unreadMessagesCount: unreadMessages.size,
        );

        conversations.add(conversation);
      }

      _conversationsStreamController.add(conversations);
    });

    return _conversationsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<void> initializeCurrentConversation(Conversation conversation) async {
    final existingConversationDoc =
        await _conversationsRef.where('recipients', arrayContains: conversation.currentUser.uid).get();

    dynamic newConversationDoc;

    if (existingConversationDoc.size == 0) {
      newConversationDoc = await _conversationsRef.add({
        'recipients': [conversation.currentUser.uid, conversation.otherUser.uid],
      });
    }

    _currentConversation = Conversation(
      id: newConversationDoc?.id ?? existingConversationDoc.docs.first.id,
      currentUser: conversation.currentUser,
      otherUser: conversation.otherUser,
      unreadMessagesCount: 0,
    );
  }

  @override
  Future<void> deleteConversation(Conversation conversation) async {
    await _conversationsRef.doc(conversation.id).delete();
  }

  @override
  Future<Stream<List<Message>>> getMessagesStream(Conversation conversation) async {
    // if (conversation.id == null) {
    await initializeCurrentConversation(conversation);
    // _messagesStreamController.add([]);

    _conversationsRef
        .doc(_currentConversation.id)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((messagesSnapshots) async {
      final List<Message> messages = [];

      final conversationRef = _conversationsRef.doc(_currentConversation.id);

      try {
        final lastMessageId = (await conversationRef.get()).get('last_message');

        final lastMessageDoc = await conversationRef.collection('messages').doc(lastMessageId).get();

        if (lastMessageDoc.get('receiver') == conversation.currentUser.uid) {
          for (var messageMap in messagesSnapshots.docs) {
            await conversationRef.collection('messages').doc(messageMap.id).update({'read': true});
          }

          await conversationRef.update({'last_message': FieldValue.delete()});
        }
      } on StateError {}

      for (var messageMap in messagesSnapshots.docs) {
        final senderUid = messageMap.get('sender') as String;

        //log(conversation.lastMessage!.sender.toString());

        final sender = senderUid == conversation.currentUser.uid ? conversation.currentUser : conversation.otherUser;
        final receiver = sender == conversation.currentUser ? conversation.otherUser : conversation.currentUser;

        final message = Message(
          id: messageMap.id,
          body: messageMap.get('body') as String,
          timestamp: messageMap.get('timestamp') as int,
          sender: sender,
          receiver: receiver,
        );

        messages.add(message);
      }

      _messagesStreamController.add(messages);
    });

    return _messagesStreamController.stream.asBroadcastStream();
  }

  @override
  Future<void> sendMessage(Message message) async {
    final recentMessageDoc = await _conversationsRef.doc(_currentConversation.id).collection('messages').add({
      'body': message.body,
      'timestamp': message.timestamp,
      'sender': message.sender.uid,
      'receiver': message.receiver.uid,
      'read': false
    });

    await _conversationsRef.doc(_currentConversation.id).update({'last_message': recentMessageDoc.id});
  }

  @override
  Future<void> deleteMessage({required Conversation conversation, required Message message}) async {
    await _conversationsRef.doc(conversation.id).collection('messages').doc(message.id).delete();
  }

  @override
  Future<void> downloadFile(Message message) async {
    throw UnimplementedError();
  }
}
