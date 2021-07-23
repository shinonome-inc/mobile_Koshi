import 'package:flutter/material.dart';

void main() {
  runApp(TopPage());
}
class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.luminosity
                ),
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: Container(color: Colors.grey.withAlpha(0),)),
              Container(
                child: Material(
                  color: Colors.transparent,
                  child: Text("Qiita Feed app",
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: Colors.transparent,
                  child: Text("-playground-",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 5, child: Container(color: Colors.grey.withAlpha(0))),
              SizedBox(
                height: 50,
                width: 360,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {

                  },
                  child: Text("ログイン"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 55, top: 20,),
                height: 50,
                width: 360,
                child: FlatButton(
                  child: Text("ログインせずに利用する",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}