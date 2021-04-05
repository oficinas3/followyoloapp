//porque eu usei um monte de widget do material design
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/clients.dart';
import '../providers/client.dart';

//ctrl + . : menu de refatoracao

class LoginScreen extends StatefulWidget {
  @override
  //_LoginScreenState createState() => _LoginScreenState();
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  //estado de que tipo?

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool stayLoggedIn = false;
  var _email = TextEditingController();
  var _password = TextEditingController();

  void isLoggedIn() {
    setState(() {
      stayLoggedIn = !stayLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _clientsData = Provider.of<Clients>(context);
    final clients = _clientsData.clients;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        //ele torna a tela uma deslizavel, vertical eh o padrao
        child: Form(
          key: _formkey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/banner1.png',
                    width: 300,
                    height: 300,
                  ),
                  Card(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: 'Email'),
                      controller: _email,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter your email";
                        } else {
                          if (value == 'felipe@mememe.com') {
                            return null;
                          } else if (value == 'jose@test.com') {
                            return null;
                          } else if (_clientsData.findByEmail(value) != null) {
                            return null;
                          } else {
                            return 'Incorrect email';
                          }
                        }

                        return null;
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      controller: _password,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: stayLoggedIn,
                          onChanged: (value) {
                            setState(() {
                              stayLoggedIn = !stayLoggedIn;
                            });
                          }),
                      Text('Stay Logged In')
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        if (_email.text == 'felipe@mememe.com' ||
                            _email.text == 'jose@test.com' ||
                            _clientsData.findByEmail(_email.text) != null) {
                          Navigator.of(context)
                              .pushNamed('/home', arguments: _email.text);
                        }

                        //Navigator.pushNamed(context, '/home');

                      }
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text('Create Account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
