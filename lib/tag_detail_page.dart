import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/feed_error_page.dart';
import 'package:mobile_qiita_application/item_list.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';


class tagDetailPage extends StatefulWidget {
  final String tagId;
  tagDetailPage({Key? key, required this.tagId}) : super(key: key);
  @override
  _tagDetailPageState createState() => _tagDetailPageState();
}

class _tagDetailPageState extends State<tagDetailPage> {
  QiitaRepository qiitaRepository = QiitaRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.5,
        shadowColor: Color(0xFF4D000000),
        leading: BackButton(
          color: Color(0xFF468300),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.tagId,
        style: TextStyle(
          fontSize: 17,
          color: Color(0xFF000000),
        ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Container(
            color: Color(0xFFF2F2F2),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, top: 8.5, bottom: 7.5),
                  child: Text('投稿記事',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF828282),
                  ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<List<Item>>(
                future: QiitaRepository.fetchArticle(widget.tagId),
                builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                    );
                  } else if (snapshot.hasError){
                    return FeedErrorPage();
                  } else {
                    return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            QiitaRepository.fetchArticle(widget.tagId);
                          },
                            child: ItemList(items: snapshot.data!)));
                  }
                })
          ],
        ),
      ),
    );
  }
}
