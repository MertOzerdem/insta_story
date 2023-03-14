import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String profileImg;

  const User({required this.name, required this.profileImg});

  @override
  List<Object?> get props => [name, profileImg];
}
