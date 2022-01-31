import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/models/user.dart';

class FollowersList extends StatefulWidget {
  final List<User> followersList;
  FollowersList({Key? key, required this.followersList}) : super(key: key);
  @override
  _FollowersListState createState() => _FollowersListState();
}

class _FollowersListState extends State<FollowersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  onTap: () {},
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
}
