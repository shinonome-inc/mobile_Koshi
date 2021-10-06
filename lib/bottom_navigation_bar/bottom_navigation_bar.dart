import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/feed_page.dart';
import 'package:mobile_qiita_application/my_page.dart';
import 'package:mobile_qiita_application/settings_page.dart';
import '../tag_page.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    TagPage(),
    MyPage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        child: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[600],
        onTap: _onItemTapped,
      ),
    );

  }
}