import 'package:flutter/material.dart';
import 'package:mobile_qiita_application/top_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        initialRoute: '/top',
        routes: {
          '/top': (context) =>  TopPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
       ),
     );
   }
 }

