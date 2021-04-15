import 'package:flutter/foundation.dart';

class Rent extends ChangeNotifier {
  int _rentTimeSeconds; // = 0;

  int getRentTimeSeconds() => _rentTimeSeconds;

  void timer(int i) {
    _rentTimeSeconds = i;
  }

  void zeraTimer() {
    _rentTimeSeconds = 0;
  }

  updateRentTime() {
    _rentTimeSeconds++;
    notifyListeners();
  }
}
