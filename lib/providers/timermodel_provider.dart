import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class TimerModel with ChangeNotifier {
  final player = AudioPlayer();

  int _timeInitialized = 30;
  int _timeBreak = 60;
  int _timeExtension = 30;
  int _timeNotifi = 5;

  int _countdownValue = 60;
  Timer? _timer;
  bool _isTimerRunning = false;
  bool _isExtension = false;
  bool _isBreak = false;
  bool _warningBackground = false;

  int get countdownValue => _countdownValue;
  bool get isTimerRunning => _isTimerRunning;
  bool get isExtension => _isExtension;
  bool get isBreak => _isBreak;
  bool get warningBackground => _warningBackground;

  void playSound({bool? end = false}) async {
    await player.setSource(
        AssetSource(end == true ? 'audio/end.wav' : 'audio/beep.wav'));
    await player.resume();
  }

  void setCountdownValue(int value, String type) {
    switch (type) {
      case 'initialized':
        _timeInitialized = value;
        break;
      case 'extension':
        _timeExtension = value;
        break;
      case 'break':
        _timeBreak = value;
        break;
      case 'notifi':
        _timeNotifi = value;
        break;
      default:
    }
    notifyListeners();
  }

  void extensionCountdown() {
    _countdownValue += _timeExtension;
    _isExtension = true;
    notifyListeners();
  }

  void startCountdown() {
    _isTimerRunning = !_isTimerRunning;
    if (_timer?.isActive == true) {
      pauseCountdown();
      notifyListeners();
    } else {
      int count = 0;
      _timer = Timer.periodic(const Duration(milliseconds: 500),
          (Timer timer) async {
        count++;
        if (_countdownValue > 0) {
          if (count % 2 == 0) {
            _countdownValue--;
            if(_countdownValue <= _timeNotifi) {
              playSound(end: _countdownValue == 0);
            }
          }
          if (_countdownValue <= _timeNotifi) {
            _warningBackground = !_warningBackground;
          }
        } else {
          _isTimerRunning = false;
          _timer!.cancel();
        }
        notifyListeners();
      });
    }
  }

  void pauseCountdown() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void reloopCountdown() {
    if (!isBreak) return;
    pauseCountdown();
    _warningBackground = false;
    _countdownValue = _timeInitialized;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200), () {
      startCountdown();
    });
  }

  void resetCountdown() {
    print('123');
    pauseCountdown();
    _countdownValue = _timeBreak;
    _warningBackground = false;
    _isBreak = false;
    _isExtension = false;
    _isTimerRunning = false;

    notifyListeners();
  }

  void breakCountdown() {
    pauseCountdown();
    _countdownValue = _timeBreak;
    _isBreak = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200), () {
      startCountdown();
    });
  }
}
