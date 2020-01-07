import 'package:flutter/material.dart';
import 'package:bidir_debter/sqflite/person.dart';
import 'package:bidir_debter/sqflite/db_helper.dart';
import 'package:bidir_debter/template.dart';

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
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Add Person'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              if (key.currentState.validate()) {
                key.currentState.save();

                List<int> _colors = [
                  Colors.green.value,
                  Colors.blue.value,
                  Colors.redAccent.value,
                  Colors.teal.value,
                  Colors.purple.value,
                  Colors.grey.value
                ];
                _colors.shuffle();

                Person person = Person(null, _firstNameController.text,
                    _lastNameController.text, _colors[0]);
                dbHelper.save(person);
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new Template()));
              }
            },
          )
        ],
        // backgroundColor: Colors.grey,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, boxScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.grey,
              expandedHeight: 200,
              floating: false,
              // pinned: true,
              primary: true,
              forceElevated: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                // title: Text("Add Person",
                //   style: TextStyle(
                //     color: Colors.white70,
                //     // fontSize: 15
                //   ),
                // ),
                background: Icon(
                  Icons.person_outline,
                  size: 220,
                  color: Colors.white70,
                ),
              ),
            )
          ];
        },
        body: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                // Container(
                //   child: Center(
                //     child: Container(
                //       width: 90,
                //       height: 90,
                //       decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           border: Border.all(
                //               color: Colors.grey, style: BorderStyle.solid)),
                //       child: Icon(
                //         Icons.camera_alt,
                //         size: 80,
                //         color: Colors.grey[400],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _firstNameController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.black,
                          // contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          labelText: "First Name",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid Name.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _lastNameController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.black,
                          // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          labelText: "Last Name",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid Name.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: _lastNameController,
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.black,
                    // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
