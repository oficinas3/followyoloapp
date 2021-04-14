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

class UserHomeScreen extends StatefulWidget {
  static const routeNate = '/user_home';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  void didRunForTheFirstTime() {
    if (_isInit) {
      setState(() {
        //aqui ele vai dizer se tá carregando ou nao
        _isLoading = true;
      });

      //final serverResponse = Provider.of<Auth>(context);
      //Provider.of<User>(context).fetchAndSetUser(name: serverResponse.userName,email: serverResponse.userEmail,balance: serverResponse.userBalance);
      Provider.of<User>(context).userData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final _loadedUser = Provider.of<User>(context);
    didRunForTheFirstTime();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('FollowYolo'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello, ' + _loadedUser.name,
                        style: TextStyle(fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: customerListTile(_loadedUser.balance.toString()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    child: Text('Rent'),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueGrey[400])),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              QRCodeReaderScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Put\nCredit',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueGrey[400])),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CreditScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Call\nAdmin',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueGrey[400])),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_loadedUser.isAdmin)
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text('Administrative tools',
                                style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ActiveUsersScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Active\nUsers',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RobotScreen(),
                                            ),
                                          );
                                        },
                                        child: Text('Robots')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  ListTile customerListTile(String balance) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.monetization_on),
        backgroundColor: Colors.blueGrey[100],
        foregroundColor: Colors.white,
      ),
      title: Text('Balance:'),
      subtitle: Text('U\$ ' + balance),
    );
  }
}
