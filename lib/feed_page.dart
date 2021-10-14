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
            });
          },
          onFieldSubmitted: (value) {
            print('onFieldSubmitted: $value');
            setState(() {
              onFieldSubmittedText = value;
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
                  future: QiitaRepository.fetchItems(_page),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Item>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ));
                    } else if (snapshot.hasError) {
                      return FeedErrorPage();
                    } else {
                      return Expanded(
                          child: RefreshIndicator(
                              onRefresh: () async {
                                QiitaRepository.fetchItems(_page);
                              },
                              child: ItemList(items: snapshot.data!)));
                    }
                  }),
            ],
          ),
        )
    );
  }
}
