import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'models/item.dart';

class ArticlePage extends StatelessWidget {
  final Item item;

  ArticlePage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Colors.grey[300],
        title: Text('article',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: item.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}