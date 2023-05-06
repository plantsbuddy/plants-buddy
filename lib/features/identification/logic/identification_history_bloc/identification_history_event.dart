part of 'identification_history_bloc.dart';

@immutable
abstract class IdentificationHistoryEvent {}

class IdentificationHistoryGetHistory extends IdentificationHistoryEvent {}

class IdentificationHistoryGetDiseases extends IdentificationHistoryEvent {}

class IdentificationHistoryGetPests extends IdentificationHistoryEvent {}
