import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/models/user.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/user_page.dart';

class FolloweesList extends StatefulWidget {
  final List<User> userList;
  final User userData;
  FolloweesList({Key? key, required this.userList, required this.userData})
      : super(key: key);

  @override
  _FolloweesListState createState() => _FolloweesListState();
}

class _FolloweesListState extends State<FolloweesList> {
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
        itemCount: widget.userList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.greyBorder, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => UserPage()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, top: 8),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  widget.userList[index].profileImageUrl),
                              radius: 19,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userList[index].name.isNotEmpty
                                    ? widget.userList[index].name
                                    : widget.userList[index].id,
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.25,
                                  color: Constants.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '@${widget.userList[index].id}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Constants.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          'Posts: ${widget.userList[index].itemsCount}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Constants.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text(
                          widget.userList[index].description != null
                              ? widget.userList[index].description!
                              : "",
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.25,
                              color: Constants.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  fetchMore() async {
    if (!_isLoading) {
      _isLoading = true;
      _page++;
      var followeesList =
          await QiitaRepository.fetchFollowees(widget.userData.id, _page);
      print(followeesList);
      setState(() {
        widget.userList.addAll(followeesList);
      });
      _isLoading = false;
    }
  }
}
