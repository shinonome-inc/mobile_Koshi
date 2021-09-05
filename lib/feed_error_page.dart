import 'package:flutter/material.dart';

class FeedErrorPage extends StatelessWidget {
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
            SizedBox(height: 180.67),
            Icon(Icons.wifi_tethering_error_rounded,
              size: 50, color: Colors.lightGreen[600],),
            SizedBox(height: 42.67),
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
                  color: Colors.grey[700]
              ),
            ),
            SizedBox(height: 6),
            Text('再度読み込みをお願いします',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700]
              ),
            ),
            SizedBox(height: 160),
            SizedBox(
              width: 327,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen[600],
                  onPrimary: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {

                },
                child: Text('再読み込みする',
                  style: TextStyle(
                    letterSpacing: 0.75,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}