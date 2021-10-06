class Tags {
  final int followersCount;
  final String iconUrl;
  final String id;
  final int itemsCount;

  Tags({
    required this.followersCount,
    required this.iconUrl,
    required this.id,
    required this.itemsCount,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      followersCount: json['followers_count'],
      iconUrl: json['icon_url'],
      id: json['id'],
      itemsCount: json['items_count'],
    );
  }
}