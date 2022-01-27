class User {
  final String id;
  final String profileImageUrl;
  final String? name;
  final String? description;
  final int followeesCount;
  final int followersCount;
  final int itemsCount;

  User({
    required this.id,
    required this.profileImageUrl,
    required this.name,
    required this.description,
    required this.followeesCount,
    required this.followersCount,
    required this.itemsCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        profileImageUrl: json['profile_image_url'],
        name: json['name'],
        description: json['description'],
        followeesCount: json['followees_count'],
        followersCount: json['followers_count'],
        itemsCount: json['items_count']);
  }
}
