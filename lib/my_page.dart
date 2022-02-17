import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/top_page.dart';
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
  int _page = 1;
  var isLogin = false;
  late Future<User> refreshMyProfile;
  late Future<List<Item>> refreshMyItemList;

  @override
  void initState() {
    refreshMyProfile = QiitaRepository.fetchAuthenticatedUser();
    refreshMyItemList = QiitaRepository.fetchAuthenticatedUserItem(_page);
    super.initState();

    QiitaRepository.accessTokenIsSaved().then((isSaved) {
      setState(() {
        isLogin = isSaved;
      });
    });
  }

  Widget loginUI() {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 256.0),
          child: FutureBuilder<User>(
            future: refreshMyProfile,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorPage(refreshFunction: () {
                  refreshMyProfile = QiitaRepository.fetchAuthenticatedUser();
                });
              } else {
                return RefreshIndicator(
                    child: MyPageUserDetail(userData: snapshot.data),
                    onRefresh: () async {
                      setState(() {
                        refreshMyProfile =
                            QiitaRepository.fetchAuthenticatedUser();
                      });
                    });
              }
            },
          ),
        ),
        const SizedBox(height: 12),
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
            future: refreshMyItemList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorPage(
                  refreshFunction: () {
                    refreshMyItemList =
                        QiitaRepository.fetchAuthenticatedUserItem(_page);
                  },
                );
              } else {
                return RefreshIndicator(
                  child: MyPageItemList(itemData: snapshot.data!),
                  onRefresh: () async {
                    setState(() {
                      refreshMyItemList =
                          QiitaRepository.fetchAuthenticatedUserItem(_page);
                    });
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }

  Widget notLoginUI() {
    return Column(
      children: [
        Expanded(child: Container()),
        Text(
          'ログインが必要です',
          style: TextStyle(fontSize: 14, color: Constants.black),
        ),
        SizedBox(height: 6),
        Text(
          'マイページの機能を利用するには',
          style: TextStyle(fontSize: 12, color: Constants.grey),
        ),
        SizedBox(height: 6),
        Text(
          'ログインを行っていただく必要があります。',
          style: TextStyle(fontSize: 12, color: Constants.grey),
        ),
        Expanded(child: Container()),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                height: 50,
                child: Builder(
                  builder: (context) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Constants.secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => TopPage()));
                    },
                    child: Center(
                      child: Text(
                        'ログインする',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w700,
                          color: Constants.whiteLogin,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.white,
        title: Text(
          'MyPage',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Constants.black,
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
      body: isLogin ? loginUI() : notLoginUI(),
    );
  }
}
