import 'package:flutter/material.dart';

class RentedRobot with ChangeNotifier {
  String _robotId;
  String _status;
  String _qrcode;
  bool _isLost;

  String get status {
    return this._status;
  }

  String get qrcode {
    return this._qrcode;
  }

  void setQRCode(String value) {
    this._qrcode = value;
  }

  RentedRobot();
  //Robot({this.robotId, this.status});

  Future<void> getRobotStatus() async {
    final endpoint = 'https://followyolo.herokuapp.com/robos';
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
