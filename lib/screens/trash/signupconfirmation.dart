/* import 'package:flutter/material.dart';
import 'package:flutter_app/providers/clients.dart';
import 'package:provider/provider.dart';

class SignUpConfirmationScreen extends StatelessWidget {
  String name;
  String email;
  String phone;
  String address;
  String cpf;
  String password;
  String confirmpassword;

  SignUpConfirmationScreen(
      this.name, this.email, this.phone, this.address, this.cpf, this.password);

  @override
  Widget build(BuildContext context) {
    final clientDataFromProvider =
        Provider.of<Clients>(context).findByEmail(email);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Confirmation'),
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
                Text('Name: ' + name),
                Text('Email: ' + email),
                Text('Phone: ' + phone),
                Text('Address: ' + address),
                Text('CPF: ' + cpf),
                Text('testando provider' +
                    clientDataFromProvider.email +
                    ' ' +
                    clientDataFromProvider.id),
                ElevatedButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    //Navigator.pushNamed(context, '/login');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */