part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();

  @override
  List<Object> get props => [];
}

final class CreatingUser extends AuthenticationState {
  const CreatingUser();

  @override
  List<Object> get props => [];
}

final class GettingUsers extends AuthenticationState {
  const GettingUsers();

  @override
  List<Object> get props => [];
}

final class UserCreted extends AuthenticationState {
  const UserCreted();

  @override
  List<Object> get props => [];
}

final class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

final class AutheticationError extends AuthenticationState {
  const AutheticationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
