import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/models/tags.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class TagList extends StatefulWidget {
  final List<Tags> tags;
  TagList({Key? key, required this.tags}) : super(key: key);
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  QiitaRepository qiitaRepository = QiitaRepository();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print('Loading new Tags');
        qiitaRepository.fetchTags();
      },
      child: GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 162 / 138,
        ),
        itemCount: widget.tags.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.network(widget.tags[index].iconUrl),
                Text(widget.tags[index].id,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
                ),
                SizedBox(height: 8),
                Text('記事件数: ${widget.tags[index].itemsCount}',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF828282),
                ),
                ),
                SizedBox(height: 8),
                Text('フォロワー数: ${widget.tags[index].followersCount}',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF828282),
                ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFE0E0E0), width: 1)
            ),
          );
        },
      ),
    );
  }
}