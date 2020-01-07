import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bidir_debter/animation/fade_animation.dart';
import 'package:bidir_debter/template.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String password;
  final _passwordFieldController = TextEditingController();
  final _usernameFieldController = TextEditingController();

  bool _passwordObscure;

  @override
  void initState() {
    super.initState();
    _passwordObscure = true;
  }

  Widget signupForm() {
    return Container(
      height: 460,
      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  FadeAnimation(0.3, Center(child: Text("Welcome To Bidir app", style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.bold),))),
                  SizedBox(height: 10,),
                  FadeAnimation(0.3, Center(child: Text("Please fill the form below", style: TextStyle(color: Colors.grey),)),),
                  SizedBox(height: 10,),
                  FadeAnimation(
                      0.4,
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _usernameFieldController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "You cant have empty Name Field";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                      0.5,
                      TextFormField(
                        obscureText: _passwordObscure,
                        controller: _passwordFieldController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "You cant have empty Password Field";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_passwordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _passwordObscure = !_passwordObscure;
                                });
                              },
                            )),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: FadeAnimation(
                        0.6,
                        FlatButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          color: Colors.orange,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              if(_usernameFieldController.text == prefs.getString('username') && _passwordFieldController.text == prefs.getString('password')) {
                                await prefs.setInt('seen', 2);
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                      builder: (context) => new Template()));
                              }
                              return "Username or Password Not Correct";
                            }
                            return "Username or Password not Correct";
                          } ,
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: FadeAnimation(
                        0.3,
                        Column(
                          children: <Widget>[
                            Center(child: Icon(Icons.map, size: 100,color: Colors.white70,)),
                            Center(child: Text("Bidir App", style: TextStyle(color: Colors.white70, fontSize: 30,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))),
                          ],
                        )
                        ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.fromLTRB(18, 230, 18, 0),
                      child: signupForm()),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
