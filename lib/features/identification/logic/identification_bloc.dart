import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'identification_event.dart';
part 'identification_state.dart';

class IdentificationBloc extends Bloc<IdentificationEvent, IdentificationState> {
  IdentificationBloc() : super(IdentificationInitial()) {
    on<IdentificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
