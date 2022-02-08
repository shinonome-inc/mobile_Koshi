import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_qiita_application/models/user.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client.dart';
import 'models/item.dart';
import 'models/tags.dart';
import 'models/user.dart';

class QiitaRepository {
  static final clientID = '${Client().clientId}';
  static final clientSecret = '${Client().clientSecret}';
  static final keyAccessToken = 'qiita/accessToken';

  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<bool> accessTokenIsSaved() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  static Future<String> createAccessTokenFromCallbackUri(
      Uri uri, String expectedState) async {
    final String? state = uri.queryParameters['state'];
    final String? code = uri.queryParameters['code'];
    if (expectedState != state) {
      throw Exception('the state is different from expectedState');
    }

    final response = await http.post(
      Uri.parse('https://qiita.com/api/v2/access_tokens'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'client_id': clientID,
        'client_secret': clientSecret,
        'code': code,
      }),
    );
    final body = jsonDecode(response.body);
    final accessToken = body['token'];

    return accessToken;
  }

  static String createdAuthorizeUrl(String state) {
    final scope = 'read_qiita write_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  }

  static Future<void> deleteAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyAccessToken);
  }

  static Future<List<Item>> fetchArticle(int page, String query) async {
    final response = await http.get(Uri.parse(
        'https://qiita.com/api/v2/items?page=$page&per_page=20&query=' +
            query +
            '%3AQiita HTTP/1.1'));
    if (response.statusCode == 200) {
      print('fetchItems: Response Body');
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final articles = jsonArray.map((article) {
        return Item.fromJson(article);
      }).toList();
      return articles;
    } else {
      throw Exception('Failed to load item');
    }
  }

  static Future<User> fetchAuthenticatedUser() async {
    final accessToken = await getAccessToken();
    final response = await http.get(
      Uri.parse('https://qiita.com/api/v2/authenticated_user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = json.decode(response.body);
      var user = User.fromJson(userMap);
      print(response.body);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<List<Item>> fetchAuthenticatedUserItem() async {
    final accessToken = await getAccessToken();
    final response = await http.get(
      Uri.parse(
          'https://qiita.com/api/v2/authenticated_user/items?page=1&per_page=20'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      print('fetchAuthenticatedUserItem: Response Body');
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final items = jsonArray.map((authenticatedUserItem) {
        return Item.fromJson(authenticatedUserItem);
      }).toList();
      return items;
    } else {
      throw Exception('Failed to load authenticatedUserItems');
    }
  }

  static Future<List<User>> fetchFollowees(String userId, int page) async {
    final response = await http.get(Uri.parse(
        'https://qiita.com/api/v2/users/$userId/followees?page=$page&per_page=20'));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final followees = jsonArray.map((followees) {
        return User.fromJson(followees);
      }).toList();
      return followees;
    } else {
      throw Exception('Failed to load followees');
    }
  }

  static Future<List<User>> fetchFollowers(String userId, int page) async {
    final response = await http.get(Uri.parse(
        'https://qiita.com/api/v2/users/$userId/followers?page=$page&per_page=20'));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final followers = jsonArray.map((followers) {
        return User.fromJson(followers);
      }).toList();
      return followers;
    } else {
      throw Exception('Failed to load followersList');
    }
  }

  static Future<List<Item>> fetchItems(int page, String query) async {
    final response = await http.get(
      Uri.parse('https://qiita.com/api/v2/items?page=$page&per_page=20&query=' +
          query +
          '%3AQiita HTTP/1.1'),
    );
    if (response.statusCode == 200) {
      print('fetchItems: Response Body');
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final items = jsonArray.map((item) {
        return Item.fromJson(item);
      }).toList();
      return items;
    } else {
      throw Exception('Failed to load item');
    }
  }

  static Future<List<Tags>> fetchTags(int page) async {
    final response = await http.get(
      Uri.parse(
          'https://qiita.com/api/v2/tags?page=$page&per_page=20&sort=count'),
    );
    if (response.statusCode == 200) {
      print('fetchTags: Response Body');
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final tags = jsonArray.map((tag) {
        return Tags.fromJson(tag);
      }).toList();
      return tags;
    } else {
      throw Exception('Failed to load item');
    }
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken);
  }

  static Future<void> revokeSavedAccessToken() async {
    final accessToken = await getAccessToken();
    final response = await http.delete(
        Uri.parse('https://qiita.com/api/v2/access_tokens/$accessToken'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });

    if (response.statusCode == 204) {
      print("accessToken deleted");
    } else {
      throw Exception('Failed to revoke access token');
    }
  }

  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyAccessToken, accessToken);
  }

  static Future<User> fetchUsers(String userId) async {
    final response =
        await http.get(Uri.parse('https://qiita.com/api/v2/users/$userId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> users = json.decode(response.body);
      var user = User.fromJson(users);
      print(response.body);
      return user;
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<List<Item>> fetchUserItems(String userId, int page) async {
    final response = await http.get(Uri.parse(
        'https://qiita.com/api/v2/users/$userId/items?page=$page&per_page=20'));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> jsonArray = json.decode(response.body);
      final userItems = jsonArray.map((items) {
        return Item.fromJson(items);
      }).toList();
      return userItems;
    } else {
      throw Exception('Failed to load UserItems');
    }
  }
}
