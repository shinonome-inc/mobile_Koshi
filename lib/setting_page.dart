import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/privacy_policy_page.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/term_of_service_page.dart';
import 'package:mobile_qiita_application/top_page.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();

    QiitaRepository.accessTokenIsSaved().then((isSaved) {
      setState(() {
        isLogin = isSaved;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Constants.primary,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Text(
              'アプリ情報',
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 0.25,
                color: Constants.grey,
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Constants.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          'プライバシーポリシー',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.25,
                            color: Constants.black,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,
                            color: Constants.darkGrey),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.95,
                                child: PrivacyPolicyPage(),
                              );
                            },
                          );
                        },
                      ),
                      Divider(
                        indent: 16,
                        height: 0,
                        color: Constants.greyDivider,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Constants.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(
                          '利用規約',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.25,
                            color: Constants.black,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,
                            color: Constants.darkGrey),
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              enableDrag: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.95,
                                  child: TermOfServicePage(),
                                );
                              });
                        },
                      ),
                      Divider(
                        indent: 16,
                        height: 0,
                        color: Constants.greyDivider,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Constants.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                          leading: Text(
                            'アプリバージョン',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.25,
                              color: Constants.black,
                            ),
                          ),
                          trailing: DefaultTextStyle(
                            style: TextStyle(
                              color: Constants.black,
                              fontSize: 14,
                              letterSpacing: 0.25,
                            ),
                            child: FutureBuilder<String>(
                              future: QiitaRepository().getVersionNumber(),
                              builder: (context, snapshot) {
                                final version = snapshot.data ?? '';
                                return Text('v $version');
                              },
                            ),
                          )),
                      Divider(
                        indent: 16,
                        height: 0,
                        color: Constants.greyDivider,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 36),
          if (isLogin == true)
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                'その他',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.25,
                  color: Constants.grey,
                ),
              ),
            ),
          SizedBox(height: 8),
          if (isLogin == true)
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(color: Constants.white),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            'ログアウトする',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.25,
                              color: Constants.black,
                            ),
                          ),
                          onTap: () {
                            _onLogout();
                          },
                        ),
                        Divider(
                          indent: 16,
                          thickness: 0.5,
                          height: 0,
                          color: Constants.greyDivider,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _onLogout() async {
    await QiitaRepository.revokeSavedAccessToken();
    await QiitaRepository.deleteAccessToken();

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => TopPage()));
  }
}
