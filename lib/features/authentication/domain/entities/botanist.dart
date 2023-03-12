import 'package:equatable/equatable.dart';

import 'user.dart';

class Botanist extends User with EquatableMixin {
  final double consultationCharges;
  final String specialty;
  final String description;
  final String qualification;
  final String city;
  final String phoneNumber;

  Botanist({
    String? uid,
    required String username,
    required String email,
    required String profilePicture,
    String? password,
    required this.consultationCharges,
    required this.specialty,
    required this.description,
    required this.qualification,
    required this.city,
    required this.phoneNumber,
    //  required this.isLoggedIn,
  }) : super(
            uid: uid,
            username: username,
            email: email,
            profilePicture: profilePicture,
            password: password,
            userType: UserType.botanist);

  Botanist.initial()
      : consultationCharges = 0.0,
        specialty = '',
        description = '',
        qualification = '',
        phoneNumber = '',
        city = '',
        //isLoggedIn = false,
        super(username: '', email: '', profilePicture: '', userType: UserType.botanist);

  User copyWith({
    String? username,
    String? email,
    String? profilePicture,
    double? consultationCharges,
    String? specialty,
    String? description,
    String? qualification,
    String? phoneNumber,
    String? password,
    String? city,
    //bool? isLoggedIn,
  }) =>
      Botanist(
        consultationCharges: consultationCharges ?? this.consultationCharges,
        specialty: specialty ?? this.specialty,
        description: description ?? this.description,
        qualification: qualification ?? this.qualification,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        username: username ?? this.username,
        email: email ?? this.email,
        profilePicture: profilePicture ?? this.profilePicture,
        password: password ?? this.password,
        city: city ?? this.city,
        //  isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      );

  @override
  List<Object?> get props => [
        uid,
        consultationCharges,
        specialty,
        description,
        qualification,
        phoneNumber,
        username,
        email,
        profilePicture,
        password,
        city,
      ];
}
