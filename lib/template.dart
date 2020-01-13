import 'package:bidir_debter/pages/add_person.dart';
import 'package:bidir_debter/pages/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Template extends StatefulWidget {
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int _currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = HomePage();

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
      backgroundColor: Colors.grey[100],
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageStorage(
          child: currentPage,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // mini: true,
        onPressed: () {
          setState(() {
            currentPage = AddPerson();
            _currentIndex = 4;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentPage = HomePage();
                          _currentIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: _currentIndex == 0
                                ? Colors.purple
                                : Colors.black26,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: _currentIndex == 0
                                  ? Colors.purple
                                  : Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentPage = HomePage();
                          _currentIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.data_usage,
                            color: _currentIndex == 1
                                ? Colors.purple
                                : Colors.black26,
                          ),
                          Text(
                            'Orange',
                            style: TextStyle(
                              color: _currentIndex == 1
                                  ? Colors.purple
                                  : Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentPage = HomePage();
                          _currentIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.supervised_user_circle,
                            color: _currentIndex == 2
                                ? Colors.purple
                                : Colors.black26,
                          ),
                          Text(
                            'Users',
                            style: TextStyle(
                              color: _currentIndex == 2
                                  ? Colors.purple
                                  : Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentPage = HomePage();
                          _currentIndex = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.menu,
                            color: _currentIndex == 3
                                ? Colors.purple
                                : Colors.black26,
                          ),
                          Text(
                            'More',
                            style: TextStyle(
                              color: _currentIndex == 3
                                  ? Colors.purple
                                  : Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
