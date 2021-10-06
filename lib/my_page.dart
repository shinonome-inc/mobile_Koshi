import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/feed_error_page.dart';
import 'package:mobile_qiita_application/models/authenticated_user.dart';
import 'package:mobile_qiita_application/models/authenticated_user_item.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/My_page_list.dart';
import 'models/item.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  AuthenticatedUser? authenticatedUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.5,
        title: Text('MyPage',
        style: TextStyle(
          fontSize: 17,
          color: Color(0xFF000000),
          fontFamily: 'Pacifico',
        ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(authenticatedUser!.profileImageUrl),
            child: Text(''),
          ),
          Text(authenticatedUser!.name,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
          ),
          ),
          SizedBox(height: 4),
          Text('@${authenticatedUser!.id}',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF828282),
          ),
          ),
          SizedBox(height: 16),
          Text(authenticatedUser!.description,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF828282),
          ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('${authenticatedUser!.followeesCount} フォロー中',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF828282),
              ),
              ),
              SizedBox(width: 8),
              Text('${authenticatedUser!.followersCount} フォロワー',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF828282),
              ),)
            ],
          ),
          Container(
            height: 28,
            color: Color(0xFFF2F2F2),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
                    child: Text('投稿記事',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF828282),
                    ),
                    ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          FutureBuilder<List<Item>>(
              future: QiitaRepository.fetchAuthenticatedUserItem(),
              builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  );
                } else if (snapshot.hasError) {
                  return FeedErrorPage();
                } else {
                  return MyPageItem(authenticatedUserItem: snapshot.data!);
                }
          })
        ],
      )
    );
  }
}