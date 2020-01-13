import 'package:flutter/material.dart';
import 'package:bidir_debter/sqflite/person.dart';
import 'package:bidir_debter/sqflite/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bidir_debter/pages/login_page.dart';
import 'package:bidir_debter/pages/edit_profile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchFieldController = TextEditingController();
  Future<List<Person>> persons;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = new DBHelper();
  }

  Future<List<Person>> getPersons() {
    setState(() {
      persons = dbHelper.getPersons();
    });
    return persons;
  }

  Widget popupMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Colors.black54, size: 20),
      onSelected: (value) async {
        if (value == 'profile') {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new EditProfilePage()));
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        title: Container(
          height: 48,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              gradient: LinearGradient(
                  stops: [0.015, 0.015], colors: [Colors.purple, Colors.white]),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.5,
                  color: Colors.grey,
                )
              ]),
          child: Stack(alignment: Alignment.centerRight, children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 50, left: 15),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                controller: _searchFieldController,
                enableInteractiveSelection: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(fontSize: 16),
                    hoverColor: Colors.deepPurple,
                    fillColor: Colors.purple,
                    labelText: 'Yebidir Debter',
                    hasFloatingPlaceholder: false,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 19, 50, 18.8)),
              ),
            ),
            popupMenu()
          ]),
        ),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
                child: FutureBuilder(
                    future: getPersons(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(child: Text("No Record Found"));
                      } else {
                        return RefreshIndicator(
                          onRefresh: () {
                            return getPersons();
                          },
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: ListTile(
                                        onLongPress: () {},
                                        onTap: () {},
                                        leading: CircleAvatar(
                                            backgroundColor: Color(snapshot
                                                .data[index].profileColor),
                                            child: Text(
                                              snapshot.data[index].firstName[0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                        title: Text(
                                            snapshot.data[index].firstName),
                                        subtitle:
                                            Text(snapshot.data[index].lastName),
                                        trailing: IconButton(
                                          icon: Icon(Icons.chevron_right),
                                          onPressed: () {
                                            // dbHelper.delete(snapshot.data[index].id);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
