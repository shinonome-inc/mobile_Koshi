import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/item_list.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

import 'bottom_navigation_bar/bottom_navigation_bar.dart';


class tagDetailPage extends StatefulWidget {
  final String tagId;
  tagDetailPage({Key? key, required this.tagId}) : super(key: key);
  @override
  _tagDetailPageState createState() => _tagDetailPageState();
}

class _tagDetailPageState extends State<tagDetailPage> {
  QiitaRepository qiitaRepository = QiitaRepository();
  late Future<List<Item>> refreshItems;
  @override
  void initState() {
    refreshItems = QiitaRepository.fetchArticle(widget.tagId);
    super.initState();
  }
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
                future: refreshItems,
                builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                    );
                  } else if (snapshot.hasError){
                    return ErrorPage(
                      refreshFunction: () {
                        refreshItems = QiitaRepository.fetchArticle(widget.tagId);
                      },
                    );
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
  reload() {
    BottomBar();
  }
}
