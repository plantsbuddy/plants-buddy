import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/authentication/domain/entities/user.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/home/presentation/home_screen.dart';
import 'package:plants_buddy/features/payment/logic/payment_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class VideoCallInterface extends StatelessWidget {
  const VideoCallInterface(this.paymentBloc, {Key? key}) : super(key: key);

  final PaymentBloc paymentBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => previous.currentUser != current.currentUser,
      listener: (context, state) {
        if (state.currentUser != null) {
          ZegoUIKitPrebuiltCallInvitationService().init(
            appID: 752059411 /*input your AppID*/,
            appSign: 'd1844344a1f9b8cd0fa930c543c008174d1bed9ea5f8719fdf4de37b73716481' /*input your AppSign*/,
            userID: FirebaseAuth.instance.currentUser!.uid,
            userName: state.currentUser?.username ?? 'Appointment',
            plugins: [ZegoUIKitSignalingPlugin()],
            notifyWhenAppRunningInBackgroundOrQuit: true,
            isIOSSandboxEnvironment: false,
            androidNotificationConfig: ZegoAndroidNotificationConfig(
              channelID: "ZegoUIKit",
              channelName: "Call Notifications",
              sound: "zego_incoming",
            ),
            requireConfig: (data) {
              var config = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();

              final notesController = TextEditingController();

              config.onHangUpConfirmation = (BuildContext context) async {
                return await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("End call"),
                      content: const Text("Are you sure you want to exit the call?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Check so that payment is processed in botanist's app only, and not twich otherwise
                            // if (state.currentUser!.userType == UserType.botanist) {
                            final firstUserUid = FirebaseAuth.instance.currentUser!.uid;
                            final secondUserUid = data.invitees.first.id;

                            final botanistUid =
                                state.currentUser!.userType == UserType.botanist ? firstUserUid : secondUserUid;
                            final gardenerUid = botanistUid == firstUserUid ? secondUserUid : firstUserUid;

                            paymentBloc
                                .add(PaymentPerformConsultationPayment(botanist: botanistUid, gardener: gardenerUid));

                            paymentBloc.add(PaymentMarkAppointmentAsCompleted(notesController.text));

                            // }

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

              config.bottomMenuBarConfig = ZegoBottomMenuBarConfig(
                maxCount: 5,
                extendButtons: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(60, 60),
                      shape: const CircleBorder(),
                      primary: const Color(0xff2C2F3E).withOpacity(0.6),
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Note Minutes"),
                          content: TextField(
                            controller: notesController,
                            decoration: InputDecoration(
                              labelText: 'Meeting minutes',
                              contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            ),
                            maxLines: 4,
                            minLines: 1,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    ),
                    child: Icon(
                      Icons.edit_note_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
                buttons: [
                  ZegoMenuBarButtonName.toggleCameraButton,
                  ZegoMenuBarButtonName.toggleMicrophoneButton,
                  ZegoMenuBarButtonName.hangUpButton,
                  ZegoMenuBarButtonName.switchCameraButton,
                ],
              );

              return config;
            },
          );
        }
      },
      builder: (context, state) => HomeScreen(),
    );
  }
}
