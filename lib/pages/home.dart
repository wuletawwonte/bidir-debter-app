
import 'package:flutter/material.dart';
import 'package:bidir_debter/sqflite/person.dart';
import 'package:bidir_debter/sqflite/db_helper.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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


  @override
  Widget build(BuildContext context) {
    return Container(
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
                                return ListTile(
                                  onLongPress: () {},
                                  onTap: () {},
                                  leading: CircleAvatar(
                                      backgroundColor: Color(
                                          snapshot.data[index].profileColor),
                                      child: Text(
                                        snapshot.data[index].firstName[0]
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                  title: Text(snapshot.data[index].firstName),
                                  subtitle: Text(snapshot.data[index].lastName),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      dbHelper.delete(snapshot.data[index].id);
                                    },
                                  ),
                                );
                              }),
                        );
                      }
                    }))
          ],
        ),
    );
  }
}