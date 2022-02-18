import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'qiita_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bottom_navigation_bar/bottom_navigation_bar.dart';

class Login extends StatefulWidget {
  int selectedIndex;
  Login({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final QiitaRepository repository = QiitaRepository();
  bool _isLoading = false;
  String? _state;
  late final Uri uri;

  @override
  void initState() {
    super.initState();
    _state = _randomString(40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Qiita auth',
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
              if (uri.queryParameters['code'] != null) {
                _onAuthorizeCallbackIsCalled(uri);
              }
            });
          },
          gestureRecognizers: Set()
            ..add(Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer()))),
    );
  }

  void _onAuthorizeCallbackIsCalled(Uri uri) async {
    final accessToken =
        await QiitaRepository.createAccessTokenFromCallbackUri(uri, _state!);
    print('[accessToken]: $accessToken');
    await QiitaRepository.saveAccessToken(accessToken);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => BottomBar(selectedIndex: widget.selectedIndex)),
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
