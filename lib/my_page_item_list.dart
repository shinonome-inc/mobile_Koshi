import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
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
  int _page = 1;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: widget.itemData.length,
        itemBuilder: (BuildContext context, int index) {
          DateFormat format = DateFormat('yyyy/MM/dd');
          String date = format.format(
              DateTime.parse(widget.itemData[index].createdAt).toLocal());
          return Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    widget.itemData[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '@${widget.itemData[index].user.id} 投稿日: $date LGTM: ${widget.itemData[index].likesCount}',
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
                              height: MediaQuery.of(context).size.height * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              )),
                              child: ArticlePage(item: widget.itemData[index]));
                        });
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

  fetchMore() async {
    if (!_isLoading) {
      _isLoading = true;
      _page++;
      var myItemList = await QiitaRepository.fetchAuthenticatedUserItem(_page);
      print(myItemList);
      setState(() {
        widget.itemData.addAll(myItemList);
      });
      _isLoading = false;
    }
  }
}
