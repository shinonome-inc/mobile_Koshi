import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Settings',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Text('設定画面'),
    );
  }
}