import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/botanists/logic/botanist_reviews_bloc/botanist_reviews_bloc.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/consult_botanists_screen.dart';
import 'package:plants_buddy/features/botanists/presentation/common/reviews_screen.dart';

import '../../authentication/domain/entities/botanist.dart';
import '../logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

MaterialPageRoute route(Object? botanist) {
  final sl = GetIt.instance;

  botanist as Botanist;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<BotanistReviewsBloc>(
        create: (_) => BotanistReviewsBloc(botanist: botanist, sl(), sl()),
        child: ReviewsScreen(),
      );
    },
  );
}
