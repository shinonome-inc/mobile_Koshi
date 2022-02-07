import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/models/user.dart';
import 'package:mobile_qiita_application/qiita_repository.dart';
import 'package:mobile_qiita_application/user_page.dart';

class FollowersList extends StatefulWidget {
  final User userData;
  final List<User> followersList;
  FollowersList({Key? key, required this.followersList, required this.userData})
      : super(key: key);
  @override
  _FollowersListState createState() => _FollowersListState();
}

class _FollowersListState extends State<FollowersList> {
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
        itemCount: widget.followersList.length,
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
                        context,
                        MaterialPageRoute(
                            builder: (_) => UserPage(
                                userData: widget.followersList[index])));
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
                                  widget.followersList[index].profileImageUrl),
                              radius: 19,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.followersList[index].name.isNotEmpty
                                    ? widget.followersList[index].name
                                    : widget.followersList[index].id,
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.25,
                                  color: Constants.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '@${widget.followersList[index].id}',
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
                          'Posts: ${widget.followersList[index].itemsCount}',
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
                          widget.followersList[index].description != null
                              ? widget.followersList[index].description!
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
      var followers =
          await QiitaRepository.fetchFollowers(widget.userData.id, _page);
      print(followers);
      setState(() {
        widget.followersList.addAll(followers);
      });
      _isLoading = false;
    }
  }
}
