import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_qiita_application/constants.dart';

class FollowersPage extends StatefulWidget {
  FollowersPage({Key? key}) : super(key: key);
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: Constants.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('ユーザー名',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Constants.primary
        ),
        ),
        centerTitle: true,
      ),
    );
  }
}