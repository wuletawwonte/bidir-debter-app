import 'package:flutter/material.dart';
import 'package:bidir_debter/sqflite/person.dart';
import 'package:bidir_debter/sqflite/db_helper.dart';
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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[              
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _firstNameController,
                // maxLength: 40,
                enableInteractiveSelection: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelText: "First Name",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _lastNameController.clear();
                    },
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a valid Name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _lastNameController,
                enableInteractiveSelection: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelText: "Last Name",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _lastNameController.clear();
                    },
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a valid Name.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
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
      ),
    );
  }
}
