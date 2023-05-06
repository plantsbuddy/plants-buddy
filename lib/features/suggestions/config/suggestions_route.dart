import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/suggestions_bloc.dart';
import '../presentation/suggestions_screen.dart';

MaterialPageRoute route(Object? suggestionsBloc) {
  final sl = GetIt.instance;

  suggestionsBloc as SuggestionsBloc;

  suggestionsBloc.add(SuggestionsInitializeGuides());

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider.value(
        value: suggestionsBloc,
        child: SuggestionsScreen(),
      );
    },
  );
}
