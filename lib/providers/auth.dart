import 'dart:convert';
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './user.dart';

import '../models/http_exception.dart';

//'https://followyolo.herokuapp.com/'; //'URL DO NOSSO SITE';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  String _userEmail;
  String _userName;
  String _userPassword;
  double _userBalance;
  String _userCPF;
  String _userAddress;

  Map<String, String> header = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  bool get isAuth {
    if (_userEmail != null) {
      print('is auth!');
      return true;
    }
    return false;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    if (_userId == null) {
      print('userid null');
    }
    return _userId;
  }

  String get userEmail {
    return _userEmail;
  }

  String get userPassword {
    return _userPassword;
  }

  String get userName {
    return _userName;
  }

  double get userBalance {
    return _userBalance;
  }

  Future<int> login(String userEmail, String userPassword) async {
    int statusCode = 0;
    var endpoint = 'https://followyolo.herokuapp.com/login';
    var messagebody = json.encode(
      {
        'email': userEmail,
        'password': userPassword,
      },
    );

    try {
      print('entrou no try do login');
      final response = await http.post(
        endpoint,
        headers: header,
        body: messagebody,
      );

      statusCode = response.statusCode;
      print('status code $statusCode');
      if (statusCode == 200) {
        print('deu certo');

        Map<String, dynamic> extractedData = jsonDecode(response.body);
        _userName = extractedData['nome'];
        _userEmail = userEmail;
        _userPassword = userPassword;

        _savePreferences(email: userEmail, password: userPassword);
      }
    } catch (error) {
      throw error;
    } finally {
      print('end');
    }
    notifyListeners();
    return statusCode;
  }

  void _savePreferences({String email, String password}) async {
    final prefs = await SharedPreferences.getInstance();
    final userData =
        json.encode({'userEmail': userEmail, 'userPassword': userPassword});

    if (!prefs.containsKey('userData')) {
      prefs.setString('userData', userData);
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _userEmail = extractedUserData['userEmail'];
    _userPassword = extractedUserData['userPassword'];
    //faltou pegar os dados do servidor

    //login(email, password);

    notifyListeners();
    return true;
  }

  Future<int> signup({String email, String password, String name}) async {
    var endpoint = 'https://followyolo.herokuapp.com/signup';
    int statusCode = 0;
    var messagebody = json.encode(
      {
        'email': email,
        'password': password,
        //'balance': balance,
        'nome': name
      },
    );

    try {
      print('entrou no try do signup');
      final response =
          await http.post(endpoint, headers: header, body: messagebody);

      statusCode = response.statusCode;
      print('status code $statusCode');
      if (statusCode == 200) {
        print('deu certo');

        _userEmail = email;
        _userName = name;
        _userPassword = password;

        _savePreferences(email: _userEmail, password: _userPassword);
      }
    } catch (error) {
      throw error;
    }

    notifyListeners();
    return statusCode;
  }

  Future logout() async {
    _userName = null;
    _userEmail = null;
    _userBalance = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove(key)//remove so o que eu quero
    prefs.clear(); //remove tudo
  }
}
