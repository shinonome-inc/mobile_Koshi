import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/item.dart';
import 'models/user.dart';

class QiitaRepository {
  final clientID = '12e1133c98e78c6ca893200a1a77bb555f4448b2';
  final clientSecret = '7eae0943cb8dd8989bdb228f8516ebdf2dab053a';
  final keyAccessToken = 'qiita/accessToken';
  String? item;


  String createdAuthorizeUrl(String state) {
    final scope = 'read_qiita write_qiita';
    return 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
  }

  Future<String> createAccessTokenFromCallbackUri(Uri uri,
      String expectedState,) async {
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

  Future<void> revokeSavedAccessToken() async {
    final accessToken = await getAccessToken();
    final response = await http.delete(
        Uri.parse('https://qiita.com/api/v2/access_tokens/$accessToken'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        }
    );

    if (response.statusCode == 404) {
      throw Exception('Failed to revoke the access token');
    }
  }

  Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyAccessToken, accessToken);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken);
  }

  Future<void> deleteAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyAccessToken);
  }

  Future<bool> accessTokenIsSaved() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }
}