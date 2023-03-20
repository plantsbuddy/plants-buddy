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
      appID: 1726328163,
      appSign: '63d926efed87785da8233ee6ea43c25da886cc704084b062f8c7838824527533',
      userID: currentUser.uid,
      userName: currentUser.username,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
