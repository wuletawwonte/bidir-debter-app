import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Animation/FadeAnimation.dart';
import 'home_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String password;
  final _passwordFieldController = TextEditingController();
  final _usernameFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[80],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                      // borderRadius:
                      //     BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      color: Colors.yellowAccent,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    widthFactor: 0.6,
                    heightFactor: 0.6,
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      color: Colors.yellow[500],
                      child: Container(
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(45, 100, 0, 0),
                    child: FadeAnimation(
                        0.3,
                        Text(
                          'Signup',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 70,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ]),
                Container(
                    padding: EdgeInsets.only(top: 30, left: 25, right: 25),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                    0.4,
                                    TextFormField(
                                        controller: _usernameFieldController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "You cant have empty Name Field";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Name',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow))))),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                    0.5,
                                    TextFormField(
                                        obscureText: true,
                                        controller: _passwordFieldController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "You cant have empty Password Field";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow))))),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                    0.5,
                                    TextFormField(
                                        obscureText: true,
                                        validator: (value) {
                                          if (value !=
                                              _passwordFieldController.text) {
                                            return 'Retype Password';
                                          }
                                          if (value.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Confirm Password',
                                            labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.yellow))))),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(30),
                  child: FadeAnimation(
                      0.6,
                      RaisedButton(
                        child: Text('Signup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),  
                        color: Colors.orange,  
                        textColor: Colors.white,                    
                        onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                        'username', _usernameFieldController.text);
                                    await prefs.setString(
                                        'password', _passwordFieldController.text);
                                    await prefs.setInt('seen', 2);
                                    Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new HomePage()));
                                  }
                                },
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
