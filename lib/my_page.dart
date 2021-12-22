import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'models/user.dart';
import 'my_page_item_list.dart';
import 'my_page_user_detail.dart';
import 'constants.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.white,
        title: Text('MyPage',
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Pacifico',
          color: Constants.black,
        ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: FutureBuilder<User>(
              future: QiitaRepository.fetchAuthenticatedUser(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  );
                } else if (snapshot.hasError) {
                  return ErrorPage(refreshFunction: () {
                    QiitaRepository.fetchAuthenticatedUser();
                  });
                } else {
                  return MyPageUserDetail(userData: snapshot.data);
                }
              },
            ),
          ),
          SizedBox(height: 12),
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
                    child: Text('投稿記事',
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
          Center(
            child: FutureBuilder<List<Item>>(
              future: QiitaRepository.fetchAuthenticatedUserItem(),
              builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  );
                } else if (snapshot.hasError) {
                  return ErrorPage(refreshFunction: () {
                    QiitaRepository.fetchAuthenticatedUserItem();
                  },
                  );
                } else {
                  return MyPageItemList(itemData: snapshot.data!);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}