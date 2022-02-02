import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:intl/intl.dart';

class UserItem extends StatefulWidget {
  final List<Item> userItem;
  UserItem({Key? key, required this.userItem}) : super(key: key);
  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.userItem.length,
        itemBuilder: (BuildContext context, int index) {
          DateFormat format = DateFormat('yyyy/MM/dd');
          String date = format.format(
              DateTime.parse(widget.userItem[index].createdAt).toLocal());
          return Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    widget.userItem[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '@${widget.userItem[index].user.id} 投稿日: $date LGTM: ${widget.userItem[index].likesCount}',
                    maxLines: 2,
                  ),
                  onTap: () {},
                ),
                Divider(
                  indent: 16,
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
