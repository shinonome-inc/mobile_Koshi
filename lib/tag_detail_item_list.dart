import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/article_page.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:intl/intl.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class TagDetailItemList extends StatefulWidget {
  final String tagID;
  final List<Item> itemList;
  TagDetailItemList({Key? key, required this.itemList, required this.tagID}) : super(key: key);
  _TagDetailItemListState createState() => _TagDetailItemListState();
}

class _TagDetailItemListState extends State<TagDetailItemList> {
  int _page = 1;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _controller,
        itemCount: widget.itemList.length,
        itemBuilder: (BuildContext context, int index) {
          DateFormat format = DateFormat('yyyy/MM/dd');
          String date = format.format(DateTime.parse(widget.itemList[index].createdAt).toLocal());
          return Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(widget.itemList[index].user.profileImageUrl),
                    radius: 19,
                  ),
                  title: Text(widget.itemList[index].title,
                  maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('@${widget.itemList[index].user.id} 投稿日: $date LGTM: ${widget.itemList[index].likesCount}',
                  maxLines: 2,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      enableDrag: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 700,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )
                            ),
                            child: ArticlePage(item: widget.itemList[index]),
                          );
                        });
                  },
                ),
                Divider(
                  indent: 72,
                  height: 5,
                  thickness: 0.5,
                  color: Color(0xFFB2B2B2),
                ),
              ],
            ),
          );
        });
  }
  fetchMore() async {
    _page++;
    var items = await QiitaRepository.fetchArticle(_page, widget.tagID);
    print(items);
    setState(() {
      widget.itemList.addAll(items);
    });
  }
}