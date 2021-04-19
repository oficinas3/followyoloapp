import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

import 'package:flutter/material.dart';

import 'client.dart';

class Client {
  String email;
  String name;
  int robotId;

  Client({this.email, this.name, this.robotId});
}

class Clients with ChangeNotifier {
  List<Client> _clients = [];

  String _userEmail;
  String _userPassword;

  Clients();

  List<Client> get clients {
    return [..._clients];
  }

  set userEmail(String value) {
    _userEmail = value;
  }

  set userPassword(String value) {
    _userPassword = value;
  }

  Future<void> fetchAndSetActiveClients() async {
    final endpoint = 'https://followyolo.herokuapp.com/users/active';
    int statuscode = 0;
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    var messagebody =
        json.encode({'email': _userEmail, 'password': _userPassword});
    final List<Client> loadedClients = [];

    //comeca a funcao
    try {
      final response = await http.post(
        endpoint,
        headers: header,
        body: messagebody,
      );
      statuscode = response.statusCode;
      print('fetch and set clients status code:$statuscode');

      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData != null) {
        //bem facil de ser null
        for (int i = 0; i < extractedData.length; i++) {
          Client clientTemp = Client(
              email: extractedData[i]['email'],
              name: extractedData[i]['nome'],
              robotId: extractedData[i]['robot_id']);
          loadedClients.add(clientTemp);
        }

        _clients = loadedClients;
      }
    } catch (error) {
      print(error);
      throw error;
    }

    notifyListeners();
  }
}
