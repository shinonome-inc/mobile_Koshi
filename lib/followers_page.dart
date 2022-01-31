import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/followers_list.dart';
import 'package:mobile_qiita_application/models/user.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class FollowersPage extends StatefulWidget {
  final User userData;
  FollowersPage({Key? key, required this.userData}) : super(key: key);
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
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Constants.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.userData.name.isNotEmpty
              ? widget.userData.name
              : widget.userData.id,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Constants.primary),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: QiitaRepository.fetchFollowers(widget.userData.id),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return ErrorPage(refreshFunction: () {
                QiitaRepository.fetchFollowers(widget.userData.id);
              });
            } else {
              return FollowersList(followersList: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}
