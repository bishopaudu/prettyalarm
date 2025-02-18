/*import 'dart:async';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  int _minutes = 0;
  int _seconds = 0;
  Timer? timer;

  int get minutes => _minutes;
  int get seconds => _seconds;

  void setTime(int minutes, int seconds) {
    _minutes = minutes;
    _seconds = seconds;
    notifyListeners();
  }

  void startTime() {
    timer?.cancel(); // Ensure no multiple timers run
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_minutes == 0 && _seconds == 0) {
        stopTimer();
        return;
      }

      if (_seconds == 0) {
        _minutes--;
        _seconds = 59;
      } else {
        _seconds--;
      }

      notifyListeners();
    });
  }

  void stopTimer() {
    timer?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _minutes = 0;
    _seconds = 0;
    notifyListeners();
  }
}*/

import 'dart:async';
import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  int minutes = 0;
  int seconds = 0;
  int _totalSeconds = 0;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  Timer? _timer;

 bool get isRuning => _isRunning;

  void setTime(int mins, int secs) {
    minutes = mins;
    seconds = secs;
    _totalSeconds = (mins * 60) + secs;
    _elapsedSeconds = 0;
    _isRunning = false;
    notifyListeners();
  }

  void startTime() {
    if (_totalSeconds == 0 || _isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedSeconds < _totalSeconds) {
        _elapsedSeconds++;
        int remainingSeconds = _totalSeconds - _elapsedSeconds;
        minutes = remainingSeconds ~/ 60;
        seconds = remainingSeconds % 60;
        notifyListeners();
      } else {
        stopTimer();
      }
    });
  }

  void pauseTimer() {
    _isRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  void stopTimer() {
    _isRunning = false;
    _elapsedSeconds = 0;
    _timer?.cancel();
    notifyListeners();
  }

  double get progress =>
      _totalSeconds > 0 ? _elapsedSeconds / _totalSeconds : 0;
}
