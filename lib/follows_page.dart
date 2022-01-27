import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/followees_list.dart';
import 'package:mobile_qiita_application/models/user.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'constants.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Constants.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.userData.name != null
              ? widget.userData.name!
              : widget.userData.id,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Constants.primary),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 0,
            thickness: 0.5,
            color: Constants.greyDivider,
          ),
        ),
      ),
      body: Center(
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
      ),
    );
  }
}
