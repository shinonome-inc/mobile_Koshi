import 'package:mobile_qiita_application/models/user.dart';

class AuthenticatedUserItem {
  final String title;
  final User user;
  final String createdAt;
  final int likesCount;

  AuthenticatedUserItem({
    required this.title,
    required this.user,
    required this.createdAt,
    required this.likesCount,
});

  factory AuthenticatedUserItem.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUserItem(
        title: json['title'],
        user: User.fromJson(json['user']),
        createdAt: json['created_at'],
        likesCount: json['likes_count']
    );
  }
}