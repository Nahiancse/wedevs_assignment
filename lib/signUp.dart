import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wedevs_assignment/home.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

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
            // TextSpan(
            //   text: '-',
            //   style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            // ),
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
                      // _emailPasswordWidget(),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _name,
                              keyboardType: TextInputType.text,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "Please enter name";
                                }

                                return null;
                              },
                              onSaved: (String? phone) {},
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.people),
                                  hintText: 'Name',
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
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
                            TextFormField(
                                controller: _email,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Please enter email";
                                  }
                                  return null;
                                },
                                // onSaved: (String? name) {},
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: 'Email',
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
                            Column(
                              children: [
                                TextFormField(
                                  controller: _confirmpassword,
                                  // obscureText: _obscureText,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please re-enter password";
                                    }
                                    if (_password.text !=
                                        _confirmpassword.text) {
                                      return "Password Do not match";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: 'Confirm Password',
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true),
                                ),
                              ],
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
                            RegistrationUser();
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
                          //                     decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          //   gradient: LinearGradient(
                          //     colors: <Color>[Colors.orange, Colors.pink],
                          //   ),
                          // ),
                          child: Text(
                            'SignUp',
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

Future RegistrationUser() async {
     var url = 'https://apptest.dokandemo.com/wp-json/wp/v2/users/register';
     Map mapeddate = {
      'username': _name.text,
      'email': _email.text,
      'password': _password.text,
      
    };
  // var body = jsonEncode({'username': 'USERNAME', 'email': 'USERNAME', 'password': 'SECRET' });
  http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(mapeddate)
  ).then((http.Response response) {
    final int statusCode = response.statusCode;
if(statusCode==200){
  print('object');
   Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
}
  });
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
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            // onTap: () {
            //   Navigator.of(context).pop(SIGN_IN);
            //   print("Routing to Sign up screen");
            // },
            child: Text(
              "Login",
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
