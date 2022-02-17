import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/follow_follower_page.dart';
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
                  if (widget.userData.followeesCount != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FollowFollowerPage(
                                userData: widget.userData,
                                followeesTapped: true)));
                  }
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${widget.userData.followeesCount}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Constants.black,
                        )),
                    TextSpan(
                        text: ' フォロー中',
                        style: TextStyle(
                          fontSize: 12,
                          color: Constants.grey,
                        )),
                  ]),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (widget.userData.followersCount != 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FollowFollowerPage(
                                userData: widget.userData,
                                followeesTapped: false)));
                  }
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: '${widget.userData.followersCount}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Constants.black,
                    ),
                  ),
                  TextSpan(
                      text: ' フォロワー',
                      style: TextStyle(
                        fontSize: 12,
                        color: Constants.black,
                      ))
                ])),
              )
            ],
          )
        ],
      ),
    );
  }
}
