import 'package:flutter/material.dart';
import 'article_page.dart';
import 'models/item.dart';
import 'package:intl/intl.dart';

class MyPageItemList extends StatefulWidget {
  final List<Item> itemData;
  MyPageItemList({Key? key, required this.itemData}) : super(key: key);
  @override
  _MyPageItemListState createState() => _MyPageItemListState();
}

class _MyPageItemListState extends State<MyPageItemList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.itemData.length,
        itemBuilder: (BuildContext context, int index) {
          DateFormat format = DateFormat('yyyy/MM/dd');
          String date = format.format(DateTime.parse(widget.itemData[index].createdAt).toLocal());
          return Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.itemData[index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('@${widget.itemData[index].user.id} 投稿日: $date LGTM: ${widget.itemData[index].likesCount}',
                  maxLines: 2,
                  ),
                  onTap: () {
                    showModalBottomSheet<Item>(
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                              height: 700,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )
                              ),
                              child: ArticlePage(item: widget.itemData[index])
                          );
                        }
                    );
                  },
                ),
                Divider(
                  indent: 87,
                  height: 5,
                  thickness: 0.5,
                  color: Color(0xFFB2B2B2),
                )
              ],
            ),
          );
        });
  }
}