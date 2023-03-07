import 'package:plants_buddy/features/authentication/config/authentication_di.dart' as authentication;
import 'package:plants_buddy/features/botanists/config/botanists_di.dart' as botanists;
import 'package:plants_buddy/features/chat/config/chat_di.dart' as chat;
import 'package:plants_buddy/features/community/config/community_di.dart' as community;
import 'package:plants_buddy/features/reminders/config/reminders_di.dart' as reminders;

Future<void> init() async {
  authentication.init();
  botanists.init();
  chat.init();
  community.init();
  reminders.init();
}
