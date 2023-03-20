import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';
import 'package:plants_buddy/features/home/logic/home_cubit.dart';
import 'package:plants_buddy/features/home/presentation/home_screen.dart';
import 'package:plants_buddy/features/reminders/logic/reminders_bloc/reminders_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl())..add(AuthenticationInitUser()),
          ),
          BlocProvider<CommunityBloc>(
            create: (context) => CommunityBloc(sl(), sl(), sl(), sl())..add(CommunityPostsStreamInitialize()),
          ),
          BlocProvider<RemindersBloc>(
            create: (context) => RemindersBloc(sl(), sl())..add(RemindersStreamInitialize()),
          ),
        ],
        child: ZegoUIKitPrebuiltCallWithInvitation(
          appID: 1726328163 /*input your AppID*/,
          appSign: '63d926efed87785da8233ee6ea43c25da886cc704084b062f8c7838824527533' /*input your AppSign*/,
          userID: FirebaseAuth.instance.currentUser!.uid,
          userName: 'Mohsin Ismail',
          notifyWhenAppRunningInBackgroundOrQuit: true,
          isIOSSandboxEnvironment: false,
          androidNotificationConfig: ZegoAndroidNotificationConfig(
            channelID: "ZegoUIKit",
            channelName: "Call Notifications",
            sound: "zego_incoming",
          ),
          plugins: [ZegoUIKitSignalingPlugin()],
          child: HomeScreen(),
          requireConfig: (data) {
            var config = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();

            config.onHangUpConfirmation = (BuildContext context) async {
              return await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("End call", style: TextStyle(color: Colors.white70)),
                    content: const Text("Are you sure you want to exit the call?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          //TODO: detect payment here
                          // context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
                          Navigator.of(context).pop(true);
                        },
                        child: Text('End call'),
                        style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                      ),
                    ],
                  );
                },
              );
            };
            return config;
          },
        ),
      );
    },
  );
}
