import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'models/item.dart';

class ArticlePage extends StatefulWidget {
  final Item item;

  ArticlePage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late WebViewController _controller;
  double _webViewHeight = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Color(0xFFF5F5F5),
        title: Text(
          'article',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: _webViewHeight,
          child: WebView(
            initialUrl: widget.item.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) => _onPageFinished(context, url),
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _controller
          .evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }
}
