import 'package:bidir_debter/pages/add_person.dart';
import 'package:bidir_debter/pages/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    HomePage(),
    AddPerson(),
    HomePage(),
  ];

  List<TabItem> items = <TabItem>[
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.data_usage, title: 'Orange'),
    TabItem(icon: Icons.add, title: 'Add Person'),
    TabItem(icon: Icons.supervised_user_circle, title: 'Users'),
    TabItem(icon: Icons.menu, title: 'More'),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  title: new Text('Are you sure?'),
                  content: Text('Do you want to exit an app?'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    new FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Yes'))
                  ],
                ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[100],
        body: _children[_currentIndex],
        bottomNavigationBar: ConvexAppBar.builder(
          count: items.length,
          backgroundColor: Colors.white,
          onTap: onTabTapped,
          style: TabStyle.custom,
          builder: _CustomTabsBuilder(items),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class _CustomTabsBuilder extends DelegateBuilder {
  final List<TabItem> items;

  _CustomTabsBuilder(this.items);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var navigationItem = items[index];
    var _color = active ? Colors.orange : Colors.white60;
    var _color2 = active ? Colors.white : Colors.black;

    if (index == items.length ~/ 2) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: 60,
            height: 60,
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _color,
                    ),
                    child: Icon(Icons.add, size: 50, color: _color2)),
              ],
            ),
          )
        ],
      );
    }

    var _icon = active
        ? navigationItem.activeIcon ?? navigationItem.icon
        : navigationItem.icon;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(_icon, color: Colors.black87),
          Text(
            navigationItem.title,
            style: TextStyle(color: Colors.black87),
          )
        ],
      ),
    );
  }
}
