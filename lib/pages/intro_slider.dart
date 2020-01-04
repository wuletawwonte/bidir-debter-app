import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signup_page.dart';

class IntroSlider extends StatelessWidget {
  final pages = [
    PageViewModel(
        pageColor: Colors.amber,
        body: Text('Welcome to the Bidir and Load management application'),
        title: Text('Welcome'),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset('assets/banner1.jpg',
            height: 285.0, width: 285.0, alignment: Alignment.center)),
    PageViewModel(
        pageColor: Colors.orange,
        body: Text('Wonderfull app for shop keepers'),
        title: Text('Shop Keepers'),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset('assets/banner2.png',
            height: 285.0, width: 285.0, alignment: Alignment.center)),
    PageViewModel(
        pageColor: Colors.purple,
        body: Text('It is a must for mini libraries app for shop keepers'),
        title: Text('Mini Libraries'),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset('assets/banner3.png',
            height: 285.0, width: 285.0, alignment: Alignment.center)),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(pages, onTapDoneButton: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('seen', 1);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new SignupPage()));
      }),
    );
  }
}
