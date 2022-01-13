import 'package:flutter/material.dart';

import 'package:wedevs_assignment/screens/signUp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
 
      home: SignUpPage(),
    );
  }
}
