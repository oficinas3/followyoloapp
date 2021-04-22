import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Robot with ChangeNotifier {
  String _qrcode; //String _qrcode;
  String _artag;
  String _state; //String _status = 'STANDBY';
  String _id; //String _robotId;
  int _robotId;
  int _cnpj;
  int _isLost;

  Robot();
  void initialize(
      {String qrcode,
      String artag,
      String state,
      String id,
      int robotId,
      int cnpj}) {
    this._qrcode = qrcode; //String _qrcode;
    this._artag = artag;
    this._state = state; //String _status = 'STANDBY';
    this._id = id; //String _robotId;
    this._robotId = robotId;
    this._cnpj = cnpj;
  }

  final server = 'https://followyolo.herokuapp.com';

  Map<String, String> header = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  get qrcode {
    return this._qrcode;
  }

  get artag {
    return this._artag;
  }

  get state {
    return this._state;
  }

  get id {
    return this._id;
  }

  get robotId {
    return this._robotId;
  }

  get cnpj {
    return this._cnpj;
  }

  set qrcode(String value) {
    this._qrcode = value;
  }

  set artag(String value) {
    this._artag = value;
  }

  set state(String value) {
    this._state = value;
  }

  set id(String value) {
    this._id = value;
  }

  set robotId(int value) {
    this._robotId = value;
  }

  set cnpj(int value) {
    this._cnpj = value;
  }

  void setQRCode(String value) {
    this._qrcode = value;
  }

  //Robot({this.robotId, this.status});
  Future<void> robotData() async {
    final endpoint = 'https://followyolo.herokuapp.com/robot/$robotId';
    final response = await http.get(endpoint);
    final extractedData = json.decode(response.body);

    _isLost = extractedData['islost'];
    notifyListeners();
  }

  bool isLost() {
    if (_isLost == 0) {
      return false;
    }
    return true;
  }

  //'https://followyolo.herokuapp.com/robot/id/lost
  //POST
  //islost

  Future<void> getRobotStatus(String qrcode) async {
    final endpoint = '$server/robos/$qrcode';
    final response = await http.get(endpoint);
    final extractedData = json.decode(response.body);

    notifyListeners();
  }

  Future<int> startRent(String qrcode) async {
    final endpoint = 'https://followyolo.herokuapp.com/robos';
    int statuscode = 0;
    return statuscode;
  }

  Future<int> stopRent(String qrcode) async {
    final endpoint = 'https://followyolo.herokuapp.com/robos';
    int statuscode = 0;
    return statuscode;
  }

  void setRentedRobot(String qrcode) {
    this._qrcode;
    notifyListeners();
  }
}
