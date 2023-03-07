import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'botanist_event.dart';
part 'botanist_state.dart';

class BotanistBloc extends Bloc<BotanistEvent, BotanistState> {
  BotanistBloc() : super(BotanistInitial()) {
    on<BotanistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
