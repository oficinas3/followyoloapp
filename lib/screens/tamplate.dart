import 'package:flutter/material.dart';

class Tamplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Screen'),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
