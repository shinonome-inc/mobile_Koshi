import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feed_page.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final QiitaRepository repository = QiitaRepository();

  String? _state;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    _state = _randomString(40);
    _subscription = uriLinkStream.listen((Uri? uri) {
      if (uri!.path == '/oauth/authorize/callback') {
        _onAuthorizeCallbackIsCalled(uri);
      }
    });
  }

  @override
  void dispose() {
    _subscription!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.luminosity,
                ),
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: Container(color: Colors.grey.withAlpha(0),)),
              Container(
                child: Material(
                  color: Colors.transparent,
                  child: Text('Qiita Feed app',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: Colors.transparent,
                  child: Text('-playground-',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 5, child: Container(color: Colors.grey.withAlpha(0))),
              SizedBox(
                height: 50,
                width: 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    onPrimary: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: _onSignInButtonIsPressed,
                  child: Text('ログイン',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 55, top: 20),
                height: 50,
                width: 360,
                child: Builder(
                  builder: (context) => FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BottomBar()),
                      );
                    },
                    child: Text('ログインせずに利用する',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _onSignInButtonIsPressed() {
    launch(repository.createdAuthorizeUrl(_state!));
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