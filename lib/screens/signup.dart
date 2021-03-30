//cadastro
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  //Campos
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

  @override
  Widget build(BuildContext context) {
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
                  ),
                ),
                Card(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: userEmail,
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Phone'),
                  ),
                ),
                Card(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'CPF'),
                    controller: userCPF,
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Address'),
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                    controller: userPassword,
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                    obscureText: true,
                    controller: userConfirmPassword,
                  ),
                ),
                ElevatedButton(
                  child: Text('Create Account'),
                  onPressed: () {
                    _trySubmit(userName.text, userCPF.text, userPassword.text);
                    Navigator.pop(context);
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
    );
  }
}
