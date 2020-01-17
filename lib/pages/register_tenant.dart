import 'package:flutter/material.dart';

class RegisterTenant extends StatefulWidget {
  @override
  _RegisterTenantState createState() => _RegisterTenantState();
}

class _RegisterTenantState extends State<RegisterTenant> {
  List<Widget> containers = [
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.blue,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text('Register Tenant'),
          bottomOpacity: 0.7,
          toolbarOpacity: 0.5,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'From Me',
                icon: Icon(Icons.call_made, color: Colors.green),
                ),
              Tab(
                text: 'To Me',
                icon: Icon(Icons.call_received, color: Colors.red)
              )
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}
