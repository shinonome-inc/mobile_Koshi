import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/followees_list.dart';
import 'package:mobile_qiita_application/models/user.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class FollowsPage extends StatefulWidget {
  final User userData;
  FollowsPage({Key? key, required this.userData}) : super(key: key);
  @override
  _FollowsPageState createState() => _FollowsPageState();
}

class _FollowsPageState extends State<FollowsPage> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<User>>(
        future: QiitaRepository.fetchFollowees(widget.userData.id, _page),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorPage(refreshFunction: () {
              QiitaRepository.fetchFollowees(widget.userData.id, _page);
            });
          } else {
            return FolloweesList(
                userList: snapshot.data!, userData: widget.userData);
          }
        },
      ),
    );
  }
}
