import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:wedevs_assignment/screens/botttomNav.dart';

import 'package:wedevs_assignment/screens/signUp.dart';

class LoginUpPage extends StatefulWidget {
  LoginUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginUpPageState createState() => _LoginUpPageState();
}

class _LoginUpPageState extends State<LoginUpPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'Dokan',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: _username,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please enter username";
                                  }
                                  return null;
                                },
                                // onSaved: (String? name) {},
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Username',
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                TextFormField(
                                  controller: _password,
                                  // obscureText: _obscureText,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please enter password";
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // _submitButton(),
                      InkWell(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            loginUser();
                            print("Successful");
                          } else {
                            print("Unsuccessfull");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      socialIconsRow(),
                      signInTextRow(),

                      SizedBox(height: height * .14),
                      // _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loginUser() async {
    var url = 'https://apptest.dokandemo.com/wp-json/jwt-auth/v1/token';
    Map mapeddate = {
      'username': _username.text,
      'password': _password.text,
    };
    // var body = jsonEncode({'username': 'USERNAME', 'email': 'USERNAME', 'password': 'SECRET' });
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: mapeddate);

    int statusCode = response.statusCode;
    var b = response.body;
    if (statusCode == 200) {
      print(b);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BotNav()));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => BotNav()));
    } else {
      print('bad request');
    }
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              "Create New Account",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue,
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
