import 'package:flutter/material.dart';

import 'client.dart';

class Clients with ChangeNotifier {
  List<Client> _clients = [];

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
