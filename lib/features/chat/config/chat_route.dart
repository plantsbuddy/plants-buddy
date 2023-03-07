import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/chat/presentation/chat_interface.dart';
import '../logic/chat_bloc.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<ChatBloc>(
        create: (_) => ChatBloc(),
        child: ChatInterface(),
      );
    },
  );
}
