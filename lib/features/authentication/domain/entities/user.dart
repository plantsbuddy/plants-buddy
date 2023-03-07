import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String profilePicture;

  User({
    required this.username,
    required this.email,
    required this.profilePicture,
    //  required this.isLoggedIn,
  });

  User.initial()
      :
        //isLoggedIn = false,
        username = '',
        email = '',
        profilePicture = '';

  User copyWith({
    String? username,
    String? email,
    String? profilePicture,
    //bool? isLoggedIn,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
        profilePicture: profilePicture ?? this.profilePicture,
        //  isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      );

  @override
  List<Object?> get props => [username, email, profilePicture];
}
