import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
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
        Container(
          margin: EdgeInsets.only(left: 24, top: 15),
          child: Text(widget.userData!.name,
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 0.25,
            color: HexColor(Constants().black),
          ),
          ),
        ),
        SizedBox(height: 4),
        Container(
          margin: EdgeInsets.only(left: 24),
          child: Text('@${widget.userData!.id}',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 0.25,
            color: HexColor(Constants().grey),
          ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 24),
          child: Text(widget.userData!.description != null ? widget.userData!.description! : "",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 0.25,
            color: HexColor(Constants().grey),
          ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 24),
          child: Row(
            children: [
              Text('${widget.userData!.followeesCount}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: HexColor(Constants().black),
              ),
              ),
              SizedBox(width: 5),
              Text('フォロー中',
              style: TextStyle(
                fontSize: 12,
                color: HexColor(Constants().grey),
              ),
              ),
              SizedBox(width: 8),
              Text('${widget.userData!.followersCount}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: HexColor(Constants().black),
              ),
              ),
              SizedBox(width: 5),
              Text('フォロワー',
              style: TextStyle(
                fontSize: 12,
                color: HexColor(Constants().black),
              ),)
            ],
          ),
        )
      ],
    );
  }
}