import 'package:flutter/material.dart';
import 'package:bidir_debter/sqflite/person.dart';
import 'package:bidir_debter/sqflite/db_helper.dart';
import 'add_person.dart';

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
        appBar: AppBar(
            // elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            title: Text('Bidir App'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.more_vert),onPressed: (){},)
            ],  
          ),
        body: CustomScrollView(          
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
                                          snapshot.data[index].firstName[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Person',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPerson()));
          },
        ),
      ),
    );
  }
}
