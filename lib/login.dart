import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
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
  late final Uri uri;
  bool _isLoading = false;

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
        initialUrl: QiitaRepository.createdAuthorizeUrl(_state!),
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() async {
            _isLoading = false;
            print(url);
            final uri = Uri.parse(url);
            if(uri.queryParameters['code'] != null) {
              _onAuthorizeCallbackIsCalled(uri);
            }
          });
        },

      ),

    );
  }
  void _onAuthorizeCallbackIsCalled(Uri uri) async {


    final accessToken =
    await QiitaRepository.createAccessTokenFromCallbackUri(uri, _state!);
    print('[accessToken]: $accessToken');
    await QiitaRepository.saveAccessToken(accessToken);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => BottomBar()),
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