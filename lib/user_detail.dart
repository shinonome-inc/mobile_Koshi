import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/followers_page.dart';
import 'package:mobile_qiita_application/follows_page.dart';
import 'package:mobile_qiita_application/models/user.dart';

class UserDetail extends StatefulWidget {
  final User userData;
  UserDetail({Key? key, required this.userData}) : super(key: key);
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.userData.profileImageUrl),
                radius: 30,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userData.name.isNotEmpty
                        ? widget.userData.name
                        : widget.userData.id,
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.25,
                        color: Constants.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@${widget.userData.id}',
                    style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.25,
                        color: Constants.grey),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.userData.description != null
                ? widget.userData.description!
                : "",
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0.25,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              FollowsPage(userData: widget.userData)));
                },
                child: Text(
                  '${widget.userData.followeesCount}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Constants.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'フォロー中',
                style: TextStyle(
                  fontSize: 12,
                  color: Constants.grey,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            FollowersPage(userData: widget.userData),
                      ));
                },
                child: Text(
                  '${widget.userData.followersCount}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Constants.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'フォロワー',
                style: TextStyle(
                  fontSize: 12,
                  color: Constants.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
