import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/error_page.dart';
import 'package:mobile_qiita_application/tag_list.dart';
import 'package:mobile_qiita_application/models/tags.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';

class TagPage extends StatefulWidget {
  TagPage({Key? key}) : super(key: key);
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  QiitaRepository qiitaRepository = QiitaRepository();
  int _page = 1;
  List<Tags> tagList = [];
  bool isLoading = false;
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
        toolbarHeight: 45,
        backgroundColor: Colors.white,
        title: Text('Tags',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Pacifico',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Center(
          child: Column(
            children: [
              FutureBuilder(
                  future: refreshTags,
                  builder: (BuildContext context, AsyncSnapshot<List<Tags>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          )
                      );
                    } else if (snapshot.hasError) {
                      return ErrorPage(
                        refreshFunction: () {
                          refreshTags = QiitaRepository.fetchTags(_page);
                        },
                      );
                    } else {
                      return Expanded(
                          child: CustomRefreshIndicator(
                            onRefresh: () async {
                              if (!isLoading) {
                                isLoading = true;
                                fetchTagsRefresh();
                                isLoading = false;
                              }
                            },
                            child: TagList(tags: snapshot.data!),
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
                  })
            ],
          ),
        ),
      ),
    );
  }

  fetchTagsRefresh() async {
      _page = 1;
      var tags = await QiitaRepository.fetchTags(_page);
      print(tags);
      setState(() {
        tagList.addAll(tags);
      });
  }
}