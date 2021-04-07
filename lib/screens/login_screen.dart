//porque eu usei um monte de widget do material design
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../screens/';
import '../screens/signup_screen.dart';

//import '../providers/';
import '../providers/auth.dart';
import '../providers/user.dart';
//import '../providers/clients.dart';
//import '../providers/client.dart';

//import '../models/';
import '../models/http_exception.dart';

//ctrl + . : menu de refatoracao

class LoginScreen extends StatefulWidget {
  static const routeNate = '/login';

  @override
  //_LoginScreenState createState() => _LoginScreenState();
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  //estado de que tipo?

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  var _email = TextEditingController();
  var _password = TextEditingController();

  Future<void> _submit() async {
    int statuscode;
    if (!_formKey.currentState.validate()) {
      // Invalid!
      //print('invalid');
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      statuscode = await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
    } catch (error) {
      print(error);
      throw error;
    }

    if (statuscode == 200) {
      setState(() {
        _isLoading = false;
      });
    } else if (statuscode == 400) {
      _showErrorDialog('User not found!');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occourred!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final _clientsData = Provider.of<Clients>(context);
    //final clients = _clientsData.clients;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        //leading: IconButton(
        //  icon: Icon(Icons.menu),
        //  onPressed: () {},
        //),
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        //ele torna a tela uma deslizavel, vertical eh o padrao
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/banner1.png',
                    width: 300,
                    height: 200,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Card(
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(hintText: 'Email'),
                                controller: _email,
                                validator: (String value) {
                                  if (value.isEmpty || !value.contains('@')) {
                                    return "Please enter your email";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                }),
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
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                          ),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            ElevatedButton(
                              child: Text('Login'),
                              onPressed: _submit,
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignUpScreen.routeNate);
                            },
                            child: Text('Create Account'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
