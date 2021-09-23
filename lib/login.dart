import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'feed_page.dart';
import 'qiita_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bottom_navigation_bar/bottom_navigation_bar.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final QiitaRepository repository = QiitaRepository();

  String? _state;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _state = _randomString(40);
    _subscription = uriLinkStream.listen((Uri? uri) {
      if (uri!.path == '/settings/applications') {
        _onAuthorizeCallbackIsCalled(uri);
      }
    });
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    _subscription!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Uri? uri;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Qiita auth',
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: 'Pacifico',
        ),
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: repository.createdAuthorizeUrl(_state!),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url == 'https://qiita.com/api/v2/access_tokens') {
            _onAuthorizeCallbackIsCalled(uri!);
          }
          return NavigationDecision.navigate;
        },

      ),

    );
  }
  void _onAuthorizeCallbackIsCalled(Uri uri) async {
    closeWebView();

    final accessToken =
    await repository.createAccessTokenFromCallbackUri(uri, _state!);
    await repository.saveAccessToken(accessToken);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => FeedPage()),
    );
  }
  String _randomString(int length) {
    final chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    final codeUnits = List.generate(length, (index) {
      final n = rand.nextInt(chars.length);
      return chars.codeUnitAt(n);
    });
    return String.fromCharCodes(codeUnits);
  }
}