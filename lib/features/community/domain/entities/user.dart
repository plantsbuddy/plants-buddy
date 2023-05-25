import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String? pictureUrl;

  const User({
    required this.uid,
    required this.name,
    required this.pictureUrl,
  });

  @override
  List<Object?> get props => [uid, name, pictureUrl];
}
