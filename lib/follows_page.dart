import 'package:flutter/material.dart';
import 'constants.dart';

class FollowsPage extends StatefulWidget {
  FollowsPage({Key? key}) : super(key: key);
  @override
  _FollowsPageState createState() => _FollowsPageState();
}

class _FollowsPageState extends State<FollowsPage> {
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