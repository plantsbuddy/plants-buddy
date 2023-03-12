import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

class DownloadFile {
  final ChatService _chatService;

  DownloadFile(this._chatService);

  Future<void> call() async {}
}
