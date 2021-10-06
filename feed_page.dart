import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class User {
  final String id;
  final String iconUrl;
  User({
    required this.id,
    required this.iconUrl,
});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      iconUrl: json['profile_image_url'],
    );
  }
}

class Article {
  final String title;
  final String url;
  final User user;

  Article({
    required this.title,
    required this.url,
    required this.user,
});
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      user: User.fromJson(json['user']),
    );
  }
}

class QiitaClient {
  static Future<List<Article>> fetchArticle() async {
    final url = 'https://qiita.com/api/v2/items' as Uri;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}

class ArticleListView extends StatelessWidget {
  final List<Article> articles;

  ArticleListView({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articles[index];
        return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(article.user.iconUrl),
            ),
            title: Text(article.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleDetailPage(article: article)),
              );
            });
      },
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  ArticleDetailPage({
    Key? key,
    required this.article,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: WebView(
            initialUrl: article.url,
          ),
        ),
      ),
    );
  }
}
class FeedPage extends StatelessWidget {
  final Future<List<Article>> articles = QiitaClient.fetchArticle();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 130,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text('Feed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Pacifico',
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 19, 0, 0),
                child: SizedBox(
                  height: 36,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Article>>(
            future: articles,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ArticleListView(articles: snapshot.data);
              }
              return CircularProgressIndicator();
            }
          ),
        ),
      ),
    );
  }
}