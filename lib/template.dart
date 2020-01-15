import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bidir_debter/pages/home.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:bidir_debter/pages/persons.dart';
import 'package:bidir_debter/pages/settings.dart';

class Template extends StatefulWidget {

  final int page;
  const Template(this.page);

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = HomePage();

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentIndex = widget.page;
    });
    if (widget.page == 0) {
      setState(() {
        currentPage = HomePage();
      });
    } else if (widget.page == 1) {
      setState(() {
        currentPage = Persons();
      });
    } else if (widget.page == 2) {
      setState(() {
        currentPage = Settings();
      });
    }
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  title: new Text('Are you sure?'),
                  content: Text('Do you want to exit the app?'),
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      backgroundColor: Colors.grey[100],
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageStorage(
          child: currentPage,
          bucket: bucket,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            setState(() {
              currentPage = HomePage();
            });
          } else if (index == 1) {
            setState(() {
              currentPage = Persons();
            });
          } else if (index == 2) {
            setState(() {
              currentPage = Settings();
            });
          }
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.purple,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.purple,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.purple,
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.supervised_user_circle,
                color: Colors.purple,
              ),
              title: Text("Persons")),
          BubbleBottomBarItem(
              backgroundColor: Colors.purple,
              icon: Icon(
                Icons.tune,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.tune,
                color: Colors.purple,
              ),
              title: Text("Settings"))
        ],
      ),

    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
