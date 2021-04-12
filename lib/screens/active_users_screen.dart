import 'package:flutter/material.dart';

class ActiveUsersScreen extends StatelessWidget {
  static const routeName = '/active_users';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Active Users'),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
