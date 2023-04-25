import 'package:plants_buddy/features/chatbot/domain/entities/chatbot_message.dart';

abstract class ChatbotService {
  Future<Map<String, String>> getChatbotResponse(String query);

  Future<String> getResponseDataFromBackend({required String intent, required String data});
}
