import 'package:flutter/material.dart';

class Setting with ChangeNotifier {
  int _timeInitialized = 10;
  int _timeBreak = 7;
  int _timeExtension = 30;
  int _timeNotifi = 5;

  int get timeInitialized => _timeInitialized;
  int get timeBreak => _timeBreak;
  int get timeExtension => _timeExtension;
  int get timeNotifi => _timeNotifi;

  void setTimeInitialized(time) {
    _timeInitialized = time;
    notifyListeners();
  }

  void setTimeBreak(time) {
    _timeBreak = time;
    notifyListeners();
  }

  void setTimeExtension(time) {
    _timeExtension = time;
    notifyListeners();
  }

  void setTimeNotifi(time) {
    _timeNotifi = time;
    notifyListeners();
  }
}
