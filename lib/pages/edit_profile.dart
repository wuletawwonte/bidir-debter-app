import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final key = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(25),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.grey, style: BorderStyle.solid)),
                      child: Icon(
                        Icons.camera_alt,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                  controller: _emailController,
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
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: _phoneNumberController,
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.black,
                    // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelText: "Phone",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid Name.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Text("Account Security", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text: "CHANGE PASSWORD",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {}),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: "ACCOUNT SETTINGS",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ;
                            }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
