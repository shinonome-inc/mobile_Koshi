import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:mobile_qiita_application/models/user.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/user_detail.dart';
import 'package:mobile_qiita_application/user_item.dart';

class UserPage extends StatefulWidget {
  final User userData;
  UserPage({Key? key, required this.userData}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _page = 1;
  late Future<User> refreshUser;
  late Future<List<Item>> refreshUserItem;

  @override
  void initState() {
    refreshUser = QiitaRepository.fetchUsers(widget.userData.id);
    refreshUserItem = QiitaRepository.fetchUserItems(widget.userData.id, _page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Constants.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Constants.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Users',
          style: TextStyle(
            fontSize: 17,
            color: Constants.primary,
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.w400,
          ),
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
      body: Column(
        children: [
          FutureBuilder<User>(
            future: refreshUser,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorPage(refreshFunction: () {
                  refreshUser = QiitaRepository.fetchUsers(widget.userData.id);
                });
              } else {
                return RefreshIndicator(
                  child: UserDetail(userData: snapshot.data!),
                  onRefresh: () async {
                    setState(() {
                      refreshUser =
                          QiitaRepository.fetchUsers(widget.userData.id);
                    });
                  },
                );
              }
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: Constants.grey6,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 16, top: 4, bottom: 8),
                    child: Text(
                      '投稿記事',
                      style: TextStyle(
                        fontSize: 12,
                        color: Constants.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: FutureBuilder<List<Item>>(
            future: refreshUserItem,
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorPage(refreshFunction: () {
                  refreshUserItem =
                      QiitaRepository.fetchUserItems(widget.userData.id, _page);
                });
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      refreshUserItem = QiitaRepository.fetchUserItems(
                          widget.userData.id, _page);
                    });
                  },
                  child: UserItem(
                      userItem: snapshot.data!, userData: widget.userData),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
