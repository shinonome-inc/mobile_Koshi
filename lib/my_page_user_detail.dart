import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/followers_page.dart';
import 'package:mobile_qiita_application/follows_page.dart';
import 'package:mobile_qiita_application/models/user.dart';

class MyPageUserDetail extends StatefulWidget {
  final User? userData;
  MyPageUserDetail({Key? key, required this.userData}) : super(key: key);
  @override
  _MyPageUserDetailState createState() => _MyPageUserDetailState();
}

class _MyPageUserDetailState extends State<MyPageUserDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 24, top: 24),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.userData!.profileImageUrl),
            radius: 43,
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 24, top: 15),
          child: Text(
            widget.userData!.name != null
                ? widget.userData!.name
                : widget.userData!.id,
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0.25,
              color: Constants.black,
            ),
          ),
        ),
        SizedBox(height: 4),
        Container(
          margin: EdgeInsets.only(left: 24),
          child: Text(
            '@${widget.userData!.id}',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0.25,
              color: Constants.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 24),
          child: Text(
            widget.userData!.description != null
                ? widget.userData!.description!
                : "",
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0.25,
              color: Constants.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 24),
          child: Row(
            children: [
              Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                FollowsPage(userData: widget.userData!)));
                  },
                  child: Text(
                    '${widget.userData!.followeesCount}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Constants.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                'フォロー中',
                style: TextStyle(
                  fontSize: 12,
                  color: Constants.grey,
                ),
              ),
              SizedBox(width: 8),
              Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => FollowersPage()));
                  },
                  child: Text(
                    '${widget.userData!.followersCount}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Constants.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                'フォロワー',
                style: TextStyle(
                  fontSize: 12,
                  color: Constants.black,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
