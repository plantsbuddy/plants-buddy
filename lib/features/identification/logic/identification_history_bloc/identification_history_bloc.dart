import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/identification_history_item.dart';
import '../../domain/usecases/identification_usecases.dart';
import '../identification_bloc/identification_bloc.dart';

part 'identification_history_event.dart';

part 'identification_history_state.dart';

class IdentificationHistoryBloc extends Bloc<IdentificationHistoryEvent, IdentificationHistoryState> {
  final GetIdentificationHistory _getIdentificationHistory;

  IdentificationHistoryBloc(this._getIdentificationHistory) : super(IdentificationHistoryState.initial()) {
    on<IdentificationHistoryGetHistory>(onIdentificationHistoryGetHistory);
  }

  FutureOr<void> onIdentificationHistoryGetHistory(
      IdentificationHistoryGetHistory event, Emitter<IdentificationHistoryState> emit) async {
    final plants = await _getIdentificationHistory(IdentificationType.plant);
    emit(state.copyWith(plants: plants, plantsStatus: HistoryStatus.loaded));

    final diseases = await _getIdentificationHistory(IdentificationType.disease);
    emit(state.copyWith(diseases: diseases, diseasesStatus: HistoryStatus.loaded));

    final pests = await _getIdentificationHistory(IdentificationType.pest);
    emit(state.copyWith(pests: pests, pestsStatus: HistoryStatus.loaded));
  }
}
