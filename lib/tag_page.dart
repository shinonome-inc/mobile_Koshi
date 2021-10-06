import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/tag_list.dart';
import 'package:mobile_qiita_application/feed_error_page.dart';
import 'package:mobile_qiita_application/models/tags.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class TagPage extends StatefulWidget {
  TagPage({Key? key}) : super(key: key);
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  QiitaRepository qiitaRepository = QiitaRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Colors.white,
        title: Text('tags',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
                future: QiitaRepository.fetchTags(),
                builder: (BuildContext context, AsyncSnapshot<List<Tags>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                    );
                  } else if (snapshot.hasError) {
                    return FeedErrorPage();
                  } else {
                    return TagList(tags: snapshot.data!);
                  }
                })
          ],
        ),
      ),
    );
  }
}