import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import './qrcodereader_screen.dart';
import './credit_screen.dart';

import '../providers/auth.dart';
import '../providers/user.dart';

import '../widgets/app_drawer.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeNate = '/client_home';

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
      final serverResponse = Provider.of<Auth>(context);

      Provider.of<User>(context).fetchAndSetUser(
          name: serverResponse.userName,
          email: serverResponse.userEmail,
          balance: serverResponse.userBalance);

      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    didRunForTheFirstTime();
    final _loadedUser = Provider.of<User>(context);

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello, ' + _loadedUser.name,
                        style: TextStyle(fontSize: 20)),
                    customerListTile(_loadedUser.balance.toString()),
                    //Text('Provider data: ' +
                    //    _loadedUser.email +
                    //   ' ' +
                    //    _loadedUser.name),
                    ElevatedButton(
                      child: Text('Rent'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QRCodeReaderScreen(),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('Call Admin'),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      child: Text('Put Credit'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreditScreen(),
                          ),
                        );
                      },
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
