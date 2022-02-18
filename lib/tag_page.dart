import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/tag_list.dart';
import 'package:mobile_qiita_application/models/tags.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class TagPage extends StatefulWidget {
  TagPage({Key? key}) : super(key: key);
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  int _page = 1;
  late Future<List<Tags>> refreshTags;

  @override
  void initState() {
    refreshTags = QiitaRepository.fetchTags(_page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 45,
        backgroundColor: Colors.white,
        title: Text(
          'Tags',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 0,
            thickness: 0.5,
            color: Constants.greyDivider,
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Center(
            child: FutureBuilder(
                future: refreshTags,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Tags>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return ErrorPage(
                      refreshFunction: () {
                        refreshTags = QiitaRepository.fetchTags(_page);
                      },
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          refreshTags = QiitaRepository.fetchTags(_page);
                        });
                      },
                      child: TagList(tags: snapshot.data!),
                    );
                  }
                })),
      ),
    );
  }
}
