import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';

class MyPageNotLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.white,
        title: Text('MyPage',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          fontFamily: 'Pacifico',
          color: Constants.primary
        ),
        ),
        centerTitle: true,
      ),
    );
  }
}