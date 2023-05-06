part of 'suggestions_bloc.dart';

@immutable
abstract class SuggestionsEvent {}

class SuggestionsInitializeTipOfTheDay extends SuggestionsEvent {}

class SuggestionsInitializeGuides extends SuggestionsEvent {}
