import 'package:flutter/material.dart';
import 'sqflite/person.dart';
import 'sqflite/db_helper.dart';
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
    getPersons();
  }

  getPersons() {
    setState(() {
      persons = dbHelper.getPersons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Text('Home page')),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
              child: FutureBuilder(
                  future: persons,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return new Container(
                          child: Center(child: Text("No Record Found")));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {},
                              leading: Icon(Icons.add_shopping_cart),
                              title:
                                  Text(snapshot.data[index].firstName),
                              subtitle:
                                  Text(snapshot.data[index].lastName),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  dbHelper.delete(snapshot.data.id);
                                },
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPerson()));
        },
      ),
    );
  }
}
