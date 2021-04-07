import 'dart:convert';
import 'dart:async';

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

  bool get isAuth {
    return _userEmail != null;
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

  String get userName {
    return _userName;
  }

  double get userBalance {
    return _userBalance;
  }

  Future<int> login(String userEmail, String userPassword) async {
    var serverUrlEndPoint = 'https://followyolo.herokuapp.com/login';
    var client = http.Client();
    int statusCode = 0;
    try {
      print('entrou no try do login');
      final response = await http
          .post(
            serverUrlEndPoint,
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: json.encode(
              {
                'email': userEmail,
                'password': userPassword,
              },
            ),
          )
          .timeout(Duration(seconds: 10));

      statusCode = response.statusCode;
      print('status code $statusCode');
      if (statusCode == 200) {
        print('deu certo');
        //final extractedData = json.decode(response.body);
        Map<String, dynamic> extractedData = jsonDecode(response.body);

        //_userEmail = extractedData['email'];
        _userName = extractedData['nome'];
        _userBalance = extractedData['balance'];
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'userEmail': userEmail,
          'userName': _userName,
        });
        prefs.setString('userData', userData);
      }
    } catch (error) {
      throw error;
    } finally {
      client.close();
    }
    return statusCode;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _userEmail = extractedUserData['userEmail'];
    if (extractedUserData['userName'] == null) {
      _userName = 'teste';
    } else {
      _userName = extractedUserData['userName'];
    }
    notifyListeners();
    return true;
  }

  Future<int> signup(
      {String email, String password, String name, double balance}) async {
    var serverUrlEndPoint = 'https://followyolo.herokuapp.com/signup';
    var client = http.Client();
    int statusCode = 0;

    try {
      print('entrou no try do signup');
      final response = await http
          .post(
            serverUrlEndPoint,
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8"
            },
            body: json.encode(
              {
                'email': email,
                'password': password,
                'balance': 320.5,
                'nome': name
              },
            ),
          )
          .timeout(Duration(seconds: 10));

      statusCode = response.statusCode;
      print('status code $statusCode');
      if (statusCode == 200) {
        print('deu certo');
        Map<String, dynamic> extractedData = jsonDecode(response.body);
        print('nome' + extractedData['nome']);
        _userEmail = email; //responseData['idToken'];
        _userName = name; //_userId = responseData['localId'];
        //final responseData = json.decode(response.body);

        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'userEmail': _token,
            'userName': _userId,
          },
        );
        prefs.setString('userData', userData);
      }
    } catch (error) {
      throw error;
    }

    return statusCode;
  }

  Future logout() async {
    _userName = null;
    _userEmail = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove(key)//remove so o que eu quero
    prefs.clear(); //remove tudo
  }
}
