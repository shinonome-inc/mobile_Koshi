class AuthenticatedUser {
  final String description;
  final int followeesCount;
  final int followersCount;
  final String profileImageUrl;
  final String name;
  final String id;

  AuthenticatedUser({
    required this.description,
    required this.followeesCount,
    required this.followersCount,
    required this.profileImageUrl,
    required this.name,
    required this.id,
});

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
        description: json['description'],
        followeesCount: json['followees_count'],
        followersCount: json['followers_count'],
        profileImageUrl: json['profile_image_url'],
        name: json['name'],
        id: json['id'],
    );
  }
}