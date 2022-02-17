import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/constants.dart';
import 'package:mobile_qiita_application/followers_page.dart';
import 'package:mobile_qiita_application/follows_page.dart';
import 'package:mobile_qiita_application/models/user.dart';

class FollowFollowerPage extends StatefulWidget {
  bool? followeesTapped;
  final User userData;
  FollowFollowerPage(
      {Key? key, required this.userData, required this.followeesTapped})
      : super(key: key);
  @override
  _FollowFollowersPageState createState() => _FollowFollowersPageState();
}

class _FollowFollowersPageState extends State<FollowFollowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constants.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Constants.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.userData.name.isNotEmpty
              ? widget.userData.name
              : widget.userData.id,
          style: TextStyle(
            color: Constants.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoSlidingSegmentedControl<bool>(
                    groupValue: widget.followeesTapped,
                    children: {
                      true: Text(
                        'フォロー中',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Constants.black,
                        ),
                      ),
                      false: Text(
                        'フォロワー',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Constants.black,
                        ),
                      )
                    },
                    onValueChanged: (switchValue) {
                      print(switchValue);
                      setState(() {
                        widget.followeesTapped = switchValue;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          (() {
            if (widget.followeesTapped == true) {
              return FollowsPage(userData: widget.userData);
            } else {
              return FollowersPage(userData: widget.userData);
            }
          })(),
        ],
      ),
    );
  }
}
