import 'package:flutter/material.dart';
import 'sqflite/person.dart';
import 'sqflite/db_helper.dart';
import 'home_page.dart';

class AddPerson extends StatefulWidget {
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final key = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = new DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Person')),
      body: Form(
        key: key,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Input field must not be empty";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "First Name",
              ),
            ),
            TextFormField(
              controller: _lastNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Input field must not be empty";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Last Name",
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (key.currentState.validate()) {
                  key.currentState.save();

                  List<int> _colors = [
                    Colors.green.value, 
                    Colors.blue.value,
                    Colors.redAccent.value,
                    Colors.teal.value,
                    Colors.purple.value,
                    ];
                  _colors.shuffle();

                  Person person = Person(null, _firstNameController.text,
                      _lastNameController.text, _colors[0]);
                  dbHelper.save(person);
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => new HomePage()));
                }
              },
              child: Text('Add Person'),
            )
          ],
        ),
      ),
    );
  }
}
