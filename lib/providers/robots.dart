import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './robot.dart';

class Robots with ChangeNotifier {
  List<Robot> _robots = [];

  //String _userEmail;
  //String _userPassword;

  Robots();

  List<Robot> get robots {
    return [..._robots];
  }

  Future<void> fetchAndSetRobots() async {
    final endpoint = 'https://followyolo.herokuapp.com/robots';
    final response = await http.get(endpoint);
    final List<Robot> loadedRobots = [];
    final extractedData =
        json.decode(response.body) as List<dynamic>; // as Map<String, dynamic>;
    print(response.body);
    if (extractedData == null) {
      return;
    }
    print('robot id: ' +
        extractedData[1]['robot_id'].toString() +
        'lengh: ${extractedData.length}');

    for (var i = 0; i < extractedData.length; i++) {
      var robot = Robot();
      robot.initialize(
          id: extractedData[i]['_id'],
          robotId: extractedData[i]['robot_id'],
          cnpj: extractedData[i]['cnpj'],
          state: extractedData[i]['state'],
          qrcode: extractedData[i]['qrcode'],
          artag: extractedData[i]['artag']);

      loadedRobots.add(robot);
      print('robotid: ${robot.robotId}');
    }

    print('tamanho da lista: ${robots.length}');
    _robots = loadedRobots;
    notifyListeners();
  }
}

//https://www.notion.so/Week-3-6e078eb5cf994537b431bb461b473a50
//https://followyolo.herokuapp.com/robos