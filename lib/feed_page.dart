import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/error_page.dart';
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
  String onFieldSubmittedText = '';
  final textController = TextEditingController();
  int _page = 1;
  List<Item> itemList = [];
  late Future<List<Item>> refreshItem;

  @override
  void initState() {
    refreshItem = QiitaRepository.fetchItems(_page, onFieldSubmittedText);
    super.initState();
  }

  Widget _textField() {
    return SizedBox(
      height: 36,
      child: TextFormField(
          autocorrect: true,
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              size: 25,
            ),
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
          onFieldSubmitted: (value) {
            print('onFieldSubmittedText: $value');
            setState(() {
              onFieldSubmittedText = value;
              refreshItem =
                  QiitaRepository.fetchItems(_page, onFieldSubmittedText);
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanDown: (_) => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.black38,
            backgroundColor: Colors.white,
            title: Text(
              'Feed',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Pacifico',
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: _textField(),
                  ),
                  Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Constants.greyDivider,
                  )
                ],
              ),
            ),
          ),
          body: Center(
            child: FutureBuilder<List<Item>>(
                future: refreshItem,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  try {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length == 0) {
                        return searchErrorPage();
                      } else {
                        return RefreshIndicator(
                            child: ItemList(
                                items: snapshot.data!,
                                onFieldSubmittedText: onFieldSubmittedText),
                            onRefresh: () async {
                              setState(() {
                                refreshItem = QiitaRepository.fetchItems(
                                    _page, onFieldSubmittedText);
                              });
                            });
                      }
                    }
                  } catch (exception) {
                    return ErrorPage(
                      refreshFunction: () {
                        refreshItem = QiitaRepository.fetchItems(
                            _page, onFieldSubmittedText);
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return ErrorPage(refreshFunction: () {
                      refreshItem = QiitaRepository.fetchItems(
                          _page, onFieldSubmittedText);
                    });
                  } else {
                    return Text('データーがありません');
                  }
                }),
          ),
        ));
  }

  Widget searchErrorPage() {
    return Column(
      children: [
        Expanded(child: Container()),
        Center(
          child: Text(
            '検索にマッチする記事はありませんでした',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            '検索条件を変えるなどして再度検索をしてください',
            style: TextStyle(
              color: Color(0xFF828282),
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
