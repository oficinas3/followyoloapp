import 'package:flutter/material.dart';

import 'package:flutter_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

//screens
import './active_users_screen.dart';
import './credit_screen.dart';
import './qrcodereader_screen.dart';
import './robots_screen.dart';

import '../providers/auth.dart';
import '../providers/user.dart';

import '../widgets/app_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = '/admin_home';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  void didRunForTheFirstTime() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('FollowYolo'),
        centerTitle: true,
      ),
    );
  }
}
