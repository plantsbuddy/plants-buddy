import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/repositories/chatbot_service.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';

class ChatbotServiceImpl implements ChatbotService {
  final DialogflowGrpcV2Beta1 dialogflow;

  ChatbotServiceImpl(this.dialogflow);

  @override
  Future<Map<String, String>> getChatbotResponse(String query) async {
    DetectIntentResponse data = await dialogflow.detectIntent(query, 'en-US');

    String body = data.queryResult.fulfillmentText;
    String intent = data.queryResult.intent.displayName;
    return {'data': body, 'intent': intent};
  }

  @override
  Future<String> getResponseDataFromBackend({required String intent, required String data}) async {
    final apiResponse = await http.post(
      Uri.parse('http://plants-buddy.herokuapp.com/chatbot'),
      encoding: Encoding.getByName('utf-8'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'intent': intent,
        'data': data,
      }),
    );

    return apiResponse.body.trim();
  }
}
