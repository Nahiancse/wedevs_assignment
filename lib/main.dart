import 'package:flutter/material.dart';
 
import 'package:wedevs_assignment/signUp.dart';

 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //    primarySwatch: Colors.blue,
      //    textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
      //      bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
      //    ),
      // ),
      
      // home: WelcomePage(),
      home: SignUpPage(),
    );
  }
}