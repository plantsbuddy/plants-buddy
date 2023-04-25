import 'package:plants_buddy/features/authentication/config/authentication_di.dart' as authentication;
import 'package:plants_buddy/features/botanists/config/botanists_di.dart' as botanists;
import 'package:plants_buddy/features/chat/config/chat_di.dart' as chat;
import 'package:plants_buddy/features/chatbot/config/chatbot_di.dart' as chatbot;
import 'package:plants_buddy/features/community/config/community_di.dart' as community;
import 'package:plants_buddy/features/collections/config/collections_di.dart' as collections;
import 'package:plants_buddy/features/reminders/config/reminders_di.dart' as reminders;
import 'package:plants_buddy/features/identification/config/identify_di.dart' as identification;
import 'package:plants_buddy/features/payment/config/payment_di.dart' as payment;
import 'package:plants_buddy/features/suggestions/config/suggestions_di.dart' as suggestions;

Future<void> init() async {
  authentication.init();
  botanists.init();
  chat.init();
  await chatbot.init();
  community.init();
  collections.init();
  reminders.init();
  identification.init();
  payment.init();
  suggestions.init();
}
