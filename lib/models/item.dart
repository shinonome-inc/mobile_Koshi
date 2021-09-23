import 'package:mobile_qiita_application/models/user.dart';

class Item {
  final String title;
  final String createdAt;
  final int likesCount;
  final User user;
  final String url;

  Item({
    required this.title,
    required this.createdAt,
    required this.likesCount,
    required this.user,
    required this.url,
});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      createdAt: json['created_at'],
      likesCount: json['likes_count'],
      user: User.fromJson(json['user']),
      url: json['url'],
    );
  }
}