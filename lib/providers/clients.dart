import 'package:flutter/material.dart';

import 'client.dart';

class Clients with ChangeNotifier {
  List<Client> _clients = [
    Client(
        id: 'c1',
        email: 'felipe@mememe.com',
        password: '1234',
        saldo: 23.0,
        nome: 'Felipe'),
    Client(
        id: 'c2',
        email: 'jose@test.com',
        password: '1111',
        saldo: 44.0,
        nome: 'José')
  ];

  void addClient(Client cli) {
    _clients.add(cli);
  }

  List<Client> get clients {
    return [..._clients];
  }

  Client findByEmail(String value) {
    return _clients.firstWhere((cli) => cli.email == value);
    //if (prod.id == id)
    //return items;
  }
}
