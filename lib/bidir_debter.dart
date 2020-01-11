import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bidir_debter/template.dart';
import 'package:bidir_debter/pages/intro_slider.dart';
import 'package:bidir_debter/pages/signup_page.dart';
import 'package:bidir_debter/pages/login_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bidir Debter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    checkFirstScreen();
  }

  Future checkFirstScreen()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _seen = (prefs.getInt('seen') ?? 0);
    
    if(_seen == 0) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new IntroSlider()));
    }
    else if(_seen == 1) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new SignupPage()));
    }
    else if(_seen == 2) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new Template()));
    }
    else if(_seen == 3) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Text(''),
      ),
    );
  }
}
