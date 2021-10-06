import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_qiita_application/models/authenticated_user_item.dart';

import 'article_page.dart';
import 'models/item.dart';

class MyPageItem extends StatefulWidget {
  final List<Item> authenticatedUserItem;
  MyPageItem({Key? key, required this.authenticatedUserItem}) : super(key: key);
  _MyPageItemState createState() => _MyPageItemState();
}

class _MyPageItemState extends State<MyPageItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.authenticatedUserItem.length,
        itemBuilder: (BuildContext context, int index) {
          DateFormat format = DateFormat('yyyy/MM/dd');
          String date = format.format(DateTime.parse(widget.authenticatedUserItem[index].createdAt).toLocal());
          return Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.authenticatedUserItem[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Row(
                    children: [
                      Text('@${widget.authenticatedUserItem[index].user.id}'),
                      SizedBox(width: 5),
                      Text('投稿日: $date'),
                      SizedBox(width: 5),
                      Text('LGTM: ${widget.authenticatedUserItem[index].likesCount}'),
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet<AuthenticatedUserItem>(
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
                              child: ArticlePage(item: widget.authenticatedUserItem[index])
                          );
                        }
                    );
                  },
                ),
                Divider(
                  height: 5,
                  thickness: 0.5,
                  color: Colors.grey[600],
                )
              ],
            ),
          );
        });
  }
}