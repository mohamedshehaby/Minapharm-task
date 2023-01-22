import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;

  const UserEntity({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}
