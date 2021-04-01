import 'client.dart';

class Clients {
  List<Client> _clients = [
    Client(id: 'c1', email: 'felipe@mememe.com', password: '1234', saldo: 23.0),
    Client(id: 'c2', email: 'jose@mememe.com', password: '1111', saldo: 44.0)
  ];

  List<Client> get clients {
    return [..._clients];
  }
}
