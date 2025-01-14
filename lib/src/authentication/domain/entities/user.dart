import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : id = 1,
        createdAt = '_empty.created_at',
        name = '_empty.name',
        avatar = '_empty.avatar';

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, createdAt, name, avatar];
}
