import 'package:equatable/equatable.dart';

import 'user.dart';

class Gardener extends User with EquatableMixin {
  Gardener({
    required String username,
    required String email,
    required String profilePicture,
    String? password,
    String? uid,
    //  required this.isLoggedIn,
  }) : super(
            username: username,
            email: email,
            profilePicture: profilePicture,
            password: password,
            userType: UserType.gardener,
            uid: uid);

  Gardener.initial()
      :
        //isLoggedIn = false,
        super(username: '', email: '', profilePicture: '', userType: UserType.gardener);

  User copyWith({
    String? username,
    String? email,
    String? profilePicture,
    String? password,
    //bool? isLoggedIn,
  }) =>
      Gardener(
        username: username ?? this.username,
        email: email ?? this.email,
        profilePicture: profilePicture ?? this.profilePicture,
        password: password ?? this.password,
        //  isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      );

  @override
  List<Object?> get props => [uid, username, email, profilePicture, password];
}
