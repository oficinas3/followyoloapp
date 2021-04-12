import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class User with ChangeNotifier {
  //final String id;
  //final String password;
  String _userEmail;
  String _userPassword;
  String _userName;
  double _userBalance;

  final serverURL = 'https://followyolo.herokuapp.com/';

  User();

  void fetchAndSetUser({String name, String email, double balance}) {
    this._userName = name;
    this._userEmail = email;
    this._userBalance = balance;
  }

  Future<int> userData() async {
    var serverUrlEndPoint = 'https://followyolo.herokuapp.com/login';
    int statusCode = 0;

    try {
      final response = await http
          .post(
            serverUrlEndPoint,
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: json.encode(
              {
                'email': _userEmail,
                'password': _userPassword,
              },
            ),
          )
          .timeout(Duration(seconds: 10));

      statusCode = response.statusCode;
      print('status code $statusCode');
      if (statusCode == 200) {
        Map<String, dynamic> extractedData = jsonDecode(response.body);

        _userName = extractedData['nome'];
        _userEmail = extractedData['email'];
        _userBalance = extractedData['balance'];
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
    return statusCode;
  }

  void logout() {
    _userEmail = null;
    _userPassword = null;
  }

  String get name {
    return this._userName;
  }

  double get balance {
    return this._userBalance;
  }

  set userName(String value) {
    _userName = value;
  }

  set userEmail(String value) {
    _userEmail = value;
  }

  set userPassword(String value) {
    _userPassword = value;
  }

  Future<int> addBalance(double addbalance) async {
    final serverUrlEndPoint = serverURL + 'addbalance';
    int statusCode = 0;

    try {
      final response = await http.post(
        serverUrlEndPoint,
        body: json.encode(
          {
            'email': _userEmail,
            'password': _userPassword,
            'balance': addbalance
          },
        ),
      );
      statusCode = response.statusCode;
    } catch (error) {
      throw error;
    }
  }
}

//5eDfWUDi9JSNkx4ZWlMmcfmc5512
//test@test.com
//Test
//99

//f4E0j2sn9qcy6OyMs1qmHFO2CDv2
//felipe@test.com
//100

//2Iylidg39JbuvwyiTdClpj3RacO2
//matheus@test.com
//200