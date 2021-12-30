import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/bottom_navigation_bar/bottom_bar2.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/my_page_not_login.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class LoadAccessToken extends StatefulWidget {
  LoadAccessToken({Key? key}) : super(key: key);
  @override
  _LoadAccessTokenState createState() => _LoadAccessTokenState();
}

class _LoadAccessTokenState extends State<LoadAccessToken> {
  Error? _error;

  @override
  void initState() {
    super.initState();

    QiitaRepository.accessTokenIsSaved().then((isSaved) {
      if (isSaved) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomBar2(selectedIndex: 2))
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPageNotLogin())
        );
      }
    }).catchError((e) {
      setState(() {
        _error = e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
      body: Center(
        child: (_error == null)
            ? CircularProgressIndicator()
            : Text(_error.toString()),
      ),
    );
  }
}