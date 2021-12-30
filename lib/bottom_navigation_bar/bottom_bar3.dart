import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/feed_page.dart';
import 'package:mobile_qiita_application/my_page_not_login.dart';
import 'package:mobile_qiita_application/settings_page.dart';
import '../tag_page.dart';

class BottomBar3 extends StatefulWidget {
  int selectedIndex;
  BottomBar3({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _BottomBar3State createState() => _BottomBar3State();
}

class _BottomBar3State extends State<BottomBar3> {
  static List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    TagPage(),
    MyPageNotLogin(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'フィード',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag),
            label: 'タグ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'マイページ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.grey[700]),
        unselectedItemColor: Colors.grey[700],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.green[600],
        onTap: _onItemTapped,
      ),
    );

  }
}