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
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: widget.tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 18, top: 16),
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Image.network(widget.tags[index].iconUrl),
                    SizedBox(height: 8),
                    Text(widget.tags[index].id,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('記事件数: ${widget.tags[index].itemsCount}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('フォロワー数: ${widget.tags[index].followersCount}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}