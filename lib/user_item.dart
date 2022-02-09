import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/article_page.dart';
import 'package:mobile_qiita_application/models/item.dart';
import 'package:intl/intl.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

import 'models/user.dart';

class UserItem extends StatefulWidget {
  final User userData;
  final List<Item> userItem;
  UserItem({Key? key, required this.userItem, required this.userData})
      : super(key: key);
  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool _isLoading = false;
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
        controller: _controller,
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
                  onTap: () {
                    showModalBottomSheet(
                        enableDrag: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(11))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: ArticlePage(item: widget.userItem[index]),
                          );
                        });
                  },
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

  fetchMore() async {
    if (!_isLoading) {
      _isLoading = true;
      _page++;
      var userItems =
          await QiitaRepository.fetchUserItems(widget.userData.id, _page);
      print(userItems);
      setState(() {
        widget.userItem.addAll(userItems);
      });
      _isLoading = false;
    }
  }
}
