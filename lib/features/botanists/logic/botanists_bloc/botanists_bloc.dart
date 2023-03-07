import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'botanists_event.dart';
part 'botanists_state.dart';

class BotanistsBloc extends Bloc<BotanistsEvent, BotanistsState> {
  BotanistsBloc() : super(BotanistsInitial()) {
    on<BotanistsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
