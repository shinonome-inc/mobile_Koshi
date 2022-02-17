import 'package:flutter/material.dart';
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
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<User>>(
        future: QiitaRepository.fetchFollowers(widget.userData.id, _page),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorPage(refreshFunction: () {
              QiitaRepository.fetchFollowers(widget.userData.id, _page);
            });
          } else {
            return FollowersList(
                followersList: snapshot.data!, userData: widget.userData);
          }
        },
      ),
    );
  }
}
