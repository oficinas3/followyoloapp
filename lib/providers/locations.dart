import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Location {
  //{"_id":"60809b84486bb1bc216a4ee0","market_cnpj":1231231,"point_x":123.123,"point_y":456.789,"point_name":"Ponto X"}
  String id;
  int cnpj;
  double x;
  double y;
  String name;

  Location({this.id, this.cnpj, this.x, this.y, this.name});
}

class Locations with ChangeNotifier {
  List<Location> _locations = [];

  List<Location> get locations {
    return [..._locations];
  }

  int size() {
    fetchAndSetLocations();
    return _locations.length;
  }

  Locations();

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

  Future<void> fetchAndSetLocations() async {
    final endpoint = 'https://followyolo.herokuapp.com/market/points';
    final response = await http.get(endpoint);
    final List<Location> loadedLocations = [];
    final extractedData = json.decode(response.body) as List<dynamic>;

    if (extractedData != null) {
      for (int i = 0; i < extractedData.length; i++) {
        //{"_id":"60809b84486bb1bc216a4ee0","market_cnpj":1231231,"point_x":123.123,"point_y":456.789,"point_name":"Ponto X"}
        Location tempLocation = Location(
            id: extractedData[i]['_i'],
            cnpj: extractedData[i]['market_cnpj'],
            x: checkDouble(extractedData[i]['point_x']),
            y: checkDouble(extractedData[i]['point_y']),
            name: extractedData[i]['point_name']);
        loadedLocations.add(tempLocation);
      }
    }

    _locations = loadedLocations;
    notifyListeners();
  }
}
