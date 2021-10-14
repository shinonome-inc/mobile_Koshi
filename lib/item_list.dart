import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_qiita_application/article_page.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'models/item.dart';
import 'package:intl/intl.dart';
import 'package:paginable/paginable.dart';

class ItemList extends StatefulWidget {
  final List<Item> items;
  ItemList({Key? key, required this.items}) : super(key: key);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  int _page = 1;
  @override
  void initState() {
    super.initState();
    _page = 1;

  }

  @override
  Widget build(BuildContext context) {
    Item? item;
    return PaginableListViewBuilder(
      loadMore: () async {
        fetchMore(item!);
        setState(() {});
      },
      errorIndicatorWidget: (exception, tryagain) => Container(
        color: Colors.redAccent,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              exception.toString(),
              style: const TextStyle(
                fontSize: 16
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)
              ),
                onPressed: tryagain,
                child: const Text('Try Again'))
          ],
        ),
      ),
      progressIndicatorWidget: const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
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
  fetchMore(Item item) async {
    await Future.delayed(const Duration(seconds: 1)
    );
    _page++;
     QiitaRepository.fetchItems(_page);
     return widget.items.add(item);
  }
}
