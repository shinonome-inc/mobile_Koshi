import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_qiita_application/article_page.dart';
import 'models/item.dart';
import 'package:intl/intl.dart';
import 'qiita_repository.dart';

class ItemList extends StatefulWidget {
  final List<Item> items;
  ItemList({Key? key, required this.items}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  QiitaRepository qiitaRepository = QiitaRepository();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              DateFormat format = DateFormat('yyyy/MM/dd');
              String date = format.format(DateTime.parse(widget.items[index].createdAt).toLocal());
              return Card(
                elevation: 0,
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(widget.items[index].user
                            .profileImageUrl),
                        radius: 19,
                      ),
                      title: Text(widget.items[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        children: [
                          Text('@${widget.items[index].user.id}'),
                          SizedBox(width: 5),
                          Text('投稿日: $date'),
                          SizedBox(width: 5),
                          Text('LGTM: ${widget.items[index].likesCount}'),
                        ],
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
                                  child: ArticlePage(item: widget.items[index])
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
            }
        );
  }
}
