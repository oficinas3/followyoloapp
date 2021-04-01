//cadastro
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './signupconfirmation.dart';
import '../providers/clients.dart';
import '../providers/client.dart';

class SignUpScreen extends StatelessWidget {
  //Campos
  var userName = TextEditingController();
  var userEmail = TextEditingController();
  var userPhone = TextEditingController();
  var userAddress = TextEditingController();
  var userCPF = TextEditingController();
  var userPassword = TextEditingController();
  var userConfirmPassword = TextEditingController();

  String _name, _email, _phone, _address, _cpf;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  _trySubmit(
    String nome,
    String cpf,
    String password,
  ) {
    print('nome: ${nome} cpf: ${cpf} password: ${password}');
  }

  @override
  Widget build(BuildContext context) {
    final clientsData = Provider.of<Clients>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Sign Up'),
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
                        onSaved: (String email) {
                          _email = email;
                        }),
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
                        decoration: InputDecoration(hintText: 'Address'),
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
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
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
                  ElevatedButton(
                    child: Text('Confirmation'),
                    onPressed: () {
                      //_trySubmit(userName.text, userCPF.text, userPassword.text);
                      //Navigator.pop(context);
                      if (_formkey.currentState.validate()) {
                        clientsData.addClient(Client(
                            id: 'c4',
                            password: userPassword.text,
                            email: userEmail.text,
                            saldo: 34524.0));
                        //print('hello');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpConfirmationScreen(
                                userName.text,
                                userEmail.text,
                                userPhone.text,
                                userAddress.text,
                                userCPF.text,
                                userPassword.text),
                          ),
                        );
                      }
                    },
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
          ),
        ),
      ),
    );
  }
}
