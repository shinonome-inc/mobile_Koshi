import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/feed_error_page.dart';
import 'item_list.dart';
import 'models/item.dart';
import 'qiita_repository.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  QiitaRepository repository = QiitaRepository();
  String onChangedText = '';
  final textController = TextEditingController();
  int _page = 1;
  List<Item> itemList = [];

  Widget _textField() {
    return SizedBox(
      height: 36,
      child: TextFormField(
          autocorrect: true,
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search,
              size: 25,),
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(40, 0, 0, 0),
            hintStyle: TextStyle(color: Color(0xFF848484), fontSize: 17),
            filled: true,
            fillColor: Color(0xFFEFEFF0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.redAccent, width: 1),
            ),
          ),
          onChanged: (value) {
            print('onchanged: $value');
            setState(() {
              onChangedText = value;
              QiitaRepository.fetchItems(_page, onChangedText);
            });
            }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black38,
          backgroundColor: Colors.white,
          title: Text('Feed',
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'Pacifico',
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: _textField(),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<List<Item>>(
                  future: QiitaRepository.fetchItems(_page, onChangedText),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Item>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                      );
                    }
                     else if (snapshot.hasError) {
                      return FeedErrorPage();
                    } else {
                      return Expanded(
                          child: CustomRefreshIndicator(
                              onRefresh: () async {
                                await Future.delayed(const Duration(seconds: 3));
                                fetchRefresh();
                              },
                              child: ItemList(items: snapshot.data!),
                              builder: (
                              BuildContext context,
                              Widget child,
                              IndicatorController controller,
                              ) {
                                return AnimatedBuilder(
                                    animation: controller,
                                    builder: (BuildContext context, _) {
                                      return Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          if(!controller.isIdle)
                                            Positioned(
                                              top: 35.0 * controller.value,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: CircularProgressIndicator(
                                                    value: !controller.isLoading
                                                        ? controller.value.clamp(0.0, 1.0)
                                                        : null,
                                                  ),
                                                ),
                                            ),
                                          Transform.translate(
                                            offset: Offset(0, 100.0 * controller.value),
                                            child: child,
                                          )
                                        ],
                                      );
                                    });
                              },
                          ));
                    }
                  }),
            ],
          ),
        )
    );
  }

  fetchRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _page = 1;
    var items = await QiitaRepository.fetchItems(_page, onChangedText);
    print(items);
    setState(() {
      itemList.addAll(items);
    });
  }
  searchErrorPage() {
    Column(
      children: [
        Center(
          child: Text('検索にマッチする記事はありませんでした',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 14,
          ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text('検索条件を変えるなどして再度検索をしてください',
          style: TextStyle(
            color: Color(0xFF828282),
            fontSize: 12,
          ),
          ),
        )
      ],
    );
  }
}
