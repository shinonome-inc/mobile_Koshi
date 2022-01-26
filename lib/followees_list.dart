import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/models/user.dart';

class FolloweesList extends StatefulWidget {
  final List<User> userList;

  FolloweesList({Key? key, required this.userList}) : super(key: key);

  @override
  _FolloweesListState createState() => _FolloweesListState();
}

class _FolloweesListState extends State<FolloweesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                                  widget.userList[index].profileImageUrl),
                              radius: 19,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userList[index].name != null
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
}
