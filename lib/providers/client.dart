import 'package:flutter/foundation.dart';

class Client {
  final String id;
  final String email;
  final String password;
  final double saldo;
  final String nome;

  Client({this.email, this.nome, this.password, this.id, this.saldo});
}
