import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/models/tags.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/tag_detail_page.dart';

class TagList extends StatefulWidget {
  final List<Tags> tags;
  TagList({Key? key, required this.tags}) : super(key: key);
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  QiitaRepository qiitaRepository = QiitaRepository();
  int _page = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchTagsMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 210,
            mainAxisExtent: 155,
            childAspectRatio: 1.28,
          ),
          itemCount: widget.tags.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
                child: Material(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => tagDetailPage(tagId: widget.tags[index].id))
                    );
              },
                  child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Image.network(widget.tags[index].iconUrl),
                              SizedBox(height: 8),
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
                        ),
                  ),
                  ),
                  );
          },
        ),
      );
  }

  fetchTagsMore() async {
    _page++;
    var tags = await QiitaRepository.fetchTags(_page);
    print(tags);
    setState(() {
      widget.tags.addAll(tags);
    });
  }
}