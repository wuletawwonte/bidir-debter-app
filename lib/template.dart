import 'package:bidir_debter/pages/add_person.dart';
import 'package:bidir_debter/pages/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:bidir_debter/pages/login_page.dart';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  final _searchFieldController = TextEditingController();
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

  Widget popupMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Colors.black54, size: 20),
      onSelected: (value) async {
        if (value == 'profile') {
          print('Profile');
        } else if (value == 'settings') {
          print('Settings');
        } else if (value == 'signout') {
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt('seen', 3);
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new LoginPage()));
        }
      },
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: "profile",
            child: Text("Profile"),
          ),
          PopupMenuItem(value: 'settings', child: Text("Settings")),
          PopupMenuItem(value: 'signout', child: Text('Signout'))
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          title: Container(
            height: 48,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.5,
                    color: Colors.grey,
                  )
                ]),
            child: Stack(alignment: Alignment.centerRight, children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 50),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  controller: _searchFieldController,
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(fontSize: 20),
                      hoverColor: Colors.deepPurple,
                      fillColor: Colors.purple,
                      prefixIcon: Icon(
                        Icons.menu,
                        size: 20,
                      ),
                      labelText: 'Bidir Debter',
                      hasFloatingPlaceholder: false,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(0, 19, 50, 18.8)),
                ),
              ),
              popupMenu()
            ]),
          ),
        ),

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
    var _color = active ? Colors.purple : Colors.white60;
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
