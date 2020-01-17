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
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

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
              "SAVE",
              style: TextStyle(color: Colors.white, fontSize: 18),
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
                dbHelper.savePerson(person);
                
                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                      builder: (context) => new Template(1)));
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
              leading: new Container(),
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
          padding: EdgeInsets.only(top: 10, right: 25),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _firstNameController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.text,
                        expands: false,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.black,
                          labelText: "First Name",
                          // labelText: _contact == null
                          //     ? "First Name"
                          //     : _contact.toString(),
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
                      width: 60,
                      child: IconButton(
                        icon: Icon(Icons.contacts, color: Colors.blue),
                        onPressed: (){}, 
                        // _getContact,                        
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      child: Icon(Icons.phone, color: Colors.deepPurple),
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _phoneController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.black,
                          labelText: "Phone",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      child: Icon(Icons.email, color: Colors.deepPurple),
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _emailController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.black,
                          labelText: "Email",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      child:
                          Icon(Icons.speaker_notes, color: Colors.deepPurple),
                    ),
                    Expanded(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: _notesController,
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.black,
                          labelText: "Note",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
