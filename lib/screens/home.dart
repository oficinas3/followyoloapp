import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './qrcodereader_screen.dart';
import 'package:flutter_app/providers/clients.dart';

String nomeCliente;
String balanceCliente;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _login = ModalRoute.of(context).settings.arguments as String;

    final _loadedLoginByProvider =
        Provider.of<Clients>(context).findByEmail(_login);

    if (_login == 'felipe@mememe.com') {
      nomeCliente = 'Felipe';
      balanceCliente = 'U\$ 45,00';
    } else {
      nomeCliente = "José";
      balanceCliente = 'U\$ 90,00';
    }

    nomeCliente = _loadedLoginByProvider.nome;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('FollowYolo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello, $nomeCliente", style: TextStyle(fontSize: 20)),
              customerListTile(nomeCliente),
              Text('Provider data: ' +
                  _loadedLoginByProvider.email +
                  ' ' +
                  _loadedLoginByProvider.id),
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
                child: Text('Make Deposit'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile customerListTile(String nomeCliente) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.monetization_on),
        backgroundColor: Colors.blueGrey[100],
        foregroundColor: Colors.white,
      ),
      title: Text('Balance:'),
      subtitle: Text(balanceCliente),
    );
  }
}
