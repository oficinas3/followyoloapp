import 'dart:convert';
import 'dart:ffi';
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
  int _isAdmin;

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
        //_userEmail = extractedData['email'];
        _userBalance = checkDouble(extractedData['balance']);
        //extractedData['balance'].toString(); //extractedData['balance'].toFloat();
        if (extractedData['adm'] == null) {
          _isAdmin = 0;
        } else {
          _isAdmin = extractedData['adm'];
        }
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
    _isAdmin = null;
    _userBalance = null;
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return value.toDouble;
    }
  }

  String get name {
    return this._userName;
  }

  double get balance {
    return this._userBalance;
  }

  String get userEmail {
    return this._userEmail;
  }

  bool get isAdmin {
    if (_isAdmin == 1) {
      return true;
    }
    return false;
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
    final serverUrlEndPoint = 'https://followyolo.herokuapp.com/addbalance';
    int statusCode = 0;

    try {
      final response = await http.post(
        serverUrlEndPoint,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode(
          {
            'email': _userEmail,
            'password': _userPassword,
            'balance': addbalance,
          },
        ),
      );
      statusCode = response.statusCode;

      final extractedData = json.decode(response.body);
      _userBalance = checkDouble(extractedData['newBalance']);

      /* print('tentando adicionar $addbalance');
      print(json.encode({
        'email': _userEmail,
        'password': _userPassword,
        'balance': addbalance,
      }));
      print('status code do addbalance $statusCode');
       */
    } catch (error) {
      throw error;
    }
    notifyListeners();
    return statusCode;
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