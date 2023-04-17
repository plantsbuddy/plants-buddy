import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/suggestions_bloc.dart';
import '../presentation/suggestions_screen.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<SuggestionsBloc>(
        create: (context) => SuggestionsBloc(sl(), sl(), sl(), sl(), sl())..add(SuggestionsInitializeGuides()),
        child: SuggestionsScreen(),
      );
    },
  );
}
