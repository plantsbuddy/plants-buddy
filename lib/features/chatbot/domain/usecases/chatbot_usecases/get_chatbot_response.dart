import 'package:plants_buddy/features/chatbot/domain/repositories/chatbot_service.dart';

import '../../entities/chatbot_message.dart';

class GetChatbotResponse {
  final ChatbotService _chatbotService;

  GetChatbotResponse(this._chatbotService);

  Future<ChatbotMessage> call(String query) async {
    final chatbotResponse = await _chatbotService.getChatbotResponse(query);

    var response = await _chatbotService.getResponseDataFromBackend(
        intent: chatbotResponse['intent'] as String, data: chatbotResponse['data'] as String);

    return ChatbotMessage(body: response.substring(1, response.length - 2), isQuery: false);
  }
}
