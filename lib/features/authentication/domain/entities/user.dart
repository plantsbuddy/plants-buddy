import 'package:equatable/equatable.dart';

enum UserType { gardener, botanist }

class User extends Equatable {
  final dynamic uid;
  final String username;
  final String email;
  final String profilePicture;
  final String? password;
  final UserType userType;

  User({
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.userType,
    this.password,
    this.uid,
  });

  // User.initial()
  //     :
  //       //isLoggedIn = false,
  //       username = '',
  //       email = '',
  //       profilePicture = '',
  //       userType = UserType.gardener,
  //       password = null;

  User copy({
    String? username,
    String? email,
    String? profilePicture,
    String? password,
    UserType? userType,
  }) =>
      User(
        uid: uid,
        username: username ?? this.username,
        email: email ?? this.email,
        profilePicture: profilePicture ?? this.profilePicture,
        userType: userType ?? this.userType,
      );

  @override
  List<Object?> get props => [
        uid,
        username,
        email,
        profilePicture,
        userType,
        password,
      ];
}
