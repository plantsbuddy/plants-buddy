import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/botanists/presentation/common/video_call_interface.dart';
import 'package:plants_buddy/features/collections/logic/collections_bloc/collections_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';
import 'package:plants_buddy/features/home/logic/home_cubit.dart';
import 'package:plants_buddy/features/reminders/logic/reminders_bloc/reminders_bloc.dart';

import '../../collections/logic/add_collection_bloc/add_collection_bloc.dart';
import '../../payment/logic/payment_bloc.dart';
import '../../suggestions/logic/suggestions_bloc.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  final paymentBloc = PaymentBloc(sl(), sl(), sl(), sl())..add(PaymentInitializePaymentDetailsStream());

  final authenticationBloc = AuthenticationBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl())
    ..add(AuthenticationInitUser());
  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          ),
          BlocProvider.value(
            value: authenticationBloc,
          ),
          BlocProvider.value(
            value: paymentBloc,
          ),
          BlocProvider<CommunityBloc>(
            create: (context) => CommunityBloc(sl(), sl(), sl())..add(CommunityPostsStreamInitialize()),
          ),
          BlocProvider<CollectionsBloc>(
            create: (context) => CollectionsBloc(sl(), sl())..add(CollectionsInitializeCollectionsStream()),
          ),
          BlocProvider<SuggestionsBloc>(
            create: (context) => SuggestionsBloc(sl(), sl(), sl(), sl(), sl())..add(SuggestionsInitializeTipOfTheDay()),
          ),
          BlocProvider<AddCollectionBloc>(
            create: (context) => AddCollectionBloc(sl()),
          ),
          BlocProvider<RemindersBloc>(
            create: (context) => RemindersBloc(sl(), sl())..add(RemindersStreamInitialize()),
          ),
        ],
        child: VideoCallInterface(paymentBloc),
      );
    },
  );
}
