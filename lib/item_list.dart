import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_qiita_application/article_page.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'models/item.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  final List<Item> items;
  ItemList({Key? key, required this.items}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  String onChangedText = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
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
                          backgroundImage: NetworkImage(widget.items[index].user.profileImageUrl),
                              radius: 19,
                      ),
                            title: Text(widget.items[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text('@${widget.items[index].user.id} 投稿日: $date LGTM: ${widget.items[index].likesCount}',
                    maxLines: 2),
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
                                indent: 72,
                                height: 5,
                                thickness: 0.5,
                                color: Color(0xFFB2B2B2),
                              ),
                        ],
                      ),
                    );
                  },
              );
  }
  fetchMore() async {
    _page++;
     var items = await QiitaRepository.fetchItems(_page, onChangedText);
     print(items);
     setState(() {
       widget.items.addAll(items);
     });
  }
}
