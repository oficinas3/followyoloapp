import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserCall {
  String id;
  String userName;
  String userEmail;
  String reason;

  UserCall({this.userEmail, this.userName, this.reason, this.id});
}

class UserCalls with ChangeNotifier {
  List<UserCall> _usercalls = [];

  UserCalls();

  List<UserCall> get userCalls {
    return [..._usercalls];
  }

  int size() {
    fetchAndSetUserCalls();
    return _usercalls.length;
  }

  Future<void> fetchAndSetUserCalls() async {
    final endpoint = 'https://followyolo.herokuapp.com/usercalls';
    final response = await http.get(endpoint);
    final List<UserCall> loadedUserCalls = [];
    final extractedData =
        json.decode(response.body) as List<dynamic>; // as Map<String, dynamic>;

    /*
    print(response.body);
     if (extractedData.length > 0) {
      print('usercall id: ' +
          extractedData[0]['_id'] +
          'lengh: ${extractedData.length}');
    }
 */
    if (extractedData != null) {
      for (int i = 0; i < extractedData.length; i++) {
        UserCall userCallTemp = UserCall(
            userEmail: extractedData[i]['email'],
            userName: extractedData[i]['name'],
            reason: extractedData[i]['reason'],
            id: extractedData[i]['_id']);
        loadedUserCalls.add(userCallTemp);
      }
    }

    print('tamanho da lista: ${loadedUserCalls.length}');
    _usercalls = loadedUserCalls;
    notifyListeners();
  }
}
