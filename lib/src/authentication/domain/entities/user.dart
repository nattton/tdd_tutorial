import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}

void main() {
  final now = DateTime.now();
  final user1 = User(
      id: 1,
      createdAt: now,
      name: 'John Doe',
      avatar: 'https://example.com/avatar.jpg');
  final user2 = User(
      id: 1,
      createdAt: now,
      name: 'John Doe',
      avatar: 'https://example.com/avatar.jpg');
  print(user1);
  print(user2);
  print(user1 == user2);
}
