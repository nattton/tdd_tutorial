part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [createdAt, name, avatar];
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
}
