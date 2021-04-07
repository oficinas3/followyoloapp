import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class User with ChangeNotifier {
  //final String id;
  //final String password;
  String _userEmail;
  String _userName;
  double _userBalance;

  User();

  void fetchAndSetUser({String name, String email, double balance}) {
    this._userName = name;
    this._userEmail = email;
    this._userBalance = balance;
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