import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: new DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.luminosity),
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              )
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text("Qiita Feed app",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(45, 0, 0, 319),
                child: Text("-playground-",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),)
            ),
            Container(
              padding: EdgeInsets.fromLTRB(54, 0, 24, 34),
              child: SizedBox(
                height: 50,
                width: 360,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text("ログイン"),
                  onPressed: () {

                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 40),
              child: SizedBox(
                child: TextButton(
                  child: Text("ログインせずに利用する",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  onPressed: () {

                  },
                ),
              ),
            ),
          ],
        ),
      ),

    );

  }
}