import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/tag_page.dart';

class TagErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Icon(Icons.wifi_tethering_error_rounded,
                size: 50, color: Color(0xFF74C13A)),
            SizedBox(height: 36),
            Text('ネットワークエラー',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text('お手数ですが電波の良い場所で',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF828282),
              ),
            ),
            SizedBox(height: 6),
            Text('再度読み込みをお願いします',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF828282),
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF74C13A),
                  onPrimary: Colors.white,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  TagPage();
                },
                child: Text('再読み込みする',
                  style: TextStyle(
                    letterSpacing: 0.75,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}