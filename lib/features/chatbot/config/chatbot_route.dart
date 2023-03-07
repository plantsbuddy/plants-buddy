import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/chatbot/presentation/chatbot_screen.dart';

import '../logic/chatbot_bloc.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<ChatbotBloc>(
        create: (context) => ChatbotBloc(),
        child: ChatbotScreen(),
      );
    },
  );
}
