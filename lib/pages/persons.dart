import 'package:flutter/material.dart';
import 'package:bidir_debter/sqflite/person.dart';
import 'package:bidir_debter/sqflite/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bidir_debter/pages/login_page.dart';
import 'package:bidir_debter/pages/edit_profile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Persons extends StatefulWidget {
  @override
  _PersonsState createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
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
        title: Text("Persons"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
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
