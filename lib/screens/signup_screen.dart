//cadastro
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'trash/signupconfirmation.dart';
import '../providers/clients.dart';
import '../providers/client.dart';

import '../providers/auth.dart';
import '../providers/user.dart';

import '../models/http_exception.dart';

class SignUpScreen extends StatefulWidget {
  static const routeNate = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name, _email, _phone, _address, _cpf;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  var userName = TextEditingController();
  var userEmail = TextEditingController();
  var userPhone = TextEditingController();
  var userAddress = TextEditingController();
  var userCPF = TextEditingController();
  var userPassword = TextEditingController();
  var userConfirmPassword = TextEditingController();

  _trySubmit(
    String nome,
    String cpf,
    String password,
  ) {
    print('nome: ${nome} cpf: ${cpf} password: ${password}');
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

  Future<void> _submit() async {
    int statuscode;
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Sign user up
      statuscode = await Provider.of<Auth>(context, listen: false).signup(
        email: _authData['email'],
        password: _authData['password'],
        name: userName.text,
      );
      print('terminou o status code como $statuscode');
    } catch (error) {
      print(error);
    }

    if (statuscode == 200) {
      setState(() {
        _isLoading = false;
      });
      print('era pra dar pop');
      Navigator.of(context).pop();
    } else if (statuscode == 400) {
      _showErrorDialog('User not found!');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        //leading: IconButton(
        //  icon: Icon(Icons.menu),
        //  onPressed: () {},
        //),
        title: Text('Sign Up'),
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
                              decoration: InputDecoration(hintText: 'Name'),
                              controller: userName,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                              onSaved: (String name) {
                                _name = name;
                              },
                            ),
                          ),
                          Card(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(hintText: 'Email'),
                              controller: userEmail,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(hintText: 'Phone'),
                                controller: userPhone,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Please enter phone number";
                                  }
                                  return null;
                                },
                                onSaved: (String phone) {
                                  _phone = phone;
                                }),
                          ),
                          Card(
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(hintText: 'CPF'),
                                keyboardType: TextInputType.number,
                                controller: userCPF,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Please enter CPF";
                                  }
                                  return null;
                                },
                                onSaved: (String cpf) {
                                  _cpf = cpf;
                                }),
                          ),
                          Card(
                            child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration:
                                    InputDecoration(hintText: 'Address'),
                                controller: userAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Please enter address";
                                  }
                                  return null;
                                },
                                onSaved: (String address) {
                                  _address = address;
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(hintText: 'Password'),
                              obscureText: true,
                              controller: userPassword,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter Password";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                            ),
                          ),
                          Card(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration:
                                  InputDecoration(hintText: 'Confirm Password'),
                              obscureText: true,
                              controller: userConfirmPassword,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please confirm your password";
                                } else if (userPassword.text !=
                                    userConfirmPassword.text) {
                                  return "The password do not match!";
                                }
                                return null;
                              },
                            ),
                          ),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            ElevatedButton(
                              child: Text('Confirmation'),
                              onPressed: _submit,
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
