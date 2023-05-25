import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../authentication/domain/entities/user.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({required this.currentUser, required this.callID, Key? key}) : super(key: key);

  final String callID;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 752059411,
      appSign: 'd1844344a1f9b8cd0fa930c543c008174d1bed9ea5f8719fdf4de37b73716481',
      userID: currentUser.uid,
      userName: currentUser.username,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
