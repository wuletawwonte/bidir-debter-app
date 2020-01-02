import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
                  color: Colors.yellow,

                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(45, 100, 0, 0),
                child: Text('Signup', style: TextStyle(color: Colors.grey, fontSize: 70, fontWeight: FontWeight.bold),),
              ),
            ]
          ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //   child: Text('.',
          //   style: TextStyle(
          //     fontSize: 80.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.orange)
          //     ),
          // )
          Container(
            padding: EdgeInsets.only(top: 30, left: 25, right: 25),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)
                    ) 

                  )
                ),
                SizedBox(height: 20,),
                                TextField(
                  decoration: InputDecoration(
                    labelText: 'PassKey',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)
                    ) 

                  )
                ),
                SizedBox(height: 40,),
                Container(
                  height: 50.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.orangeAccent,
                    color: Colors.orange,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      )
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
