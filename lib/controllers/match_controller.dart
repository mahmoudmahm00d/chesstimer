import 'dart:async';

import 'package:get/get.dart';

import '/controllers/main_controller.dart';

class MatchController extends GetxController {
  late Duration _whiteCountDownDuration;
  late Duration _blackCountDownDuration;
  late Duration _whiteDuration;
  late Duration _blackDuration;
  Timer? _whiteTimer;
  Timer? _blackTimer;

  bool _gameStarted = false;
  bool _gamePaused = false;
  bool _isWhiteTurn = false;
  String whiteTime = "00:03:00";
  String blackTime = "00:03:00";

  bool get isWhiteTurn => _isWhiteTurn;
  bool get gamePaused => _gamePaused;

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  void changePlayer(bool isWhite) {
    // Always white playing first
    if (!_gameStarted && isWhite) {
      return;
    } else if (!_gameStarted && !isWhite) {
      _gameStarted = true;
    }

    if (_gamePaused) {
      // Ignore white if it is white turn
      if (isWhite && _isWhiteTurn) {
        return;
      }

      // Ignore black if it is black turn
      if (!isWhite && !_isWhiteTurn) {
        return;
      }

      _gamePaused = false;
    }

    // Change player turn on opposite tap
    if (_isWhiteTurn && isWhite) {
      _isWhiteTurn = false;
    } else if (!_isWhiteTurn && !isWhite) {
      _isWhiteTurn = true;
    }

    if (_isWhiteTurn) {
      startWhiteTimer();
      if (_blackTimer != null && _blackTimer!.isActive) _blackTimer!.cancel();
      return;
    }

    startBlackTimer();
    if (_whiteTimer != null && _whiteTimer!.isActive) _whiteTimer!.cancel();
  }

  void startWhiteTimer() {
    if (_whiteTimer != null && _whiteTimer!.isActive) return;
    _whiteTimer = Timer.periodic(
        const Duration(milliseconds: 100), (_) => addTimeToWhite());
  }

  void startBlackTimer() {
    if (_blackTimer != null && _blackTimer!.isActive) return;
    _blackTimer = Timer.periodic(
        const Duration(milliseconds: 100), (_) => addTimeToBlack());
  }

  void addTimeToWhite() {
    final addMilliseconds = _isWhiteTurn ? -100 : 0;
    final seconds = _whiteDuration.inMilliseconds + addMilliseconds;
    if (seconds < 0) {
      endTheMatch();
    } else {
      _whiteDuration = Duration(milliseconds: seconds);
    }
    setWhiteTime();
  }

  void addTimeToBlack() {
    final addMilliseconds = !_isWhiteTurn ? -100 : 0;
    final milliseconds = _blackDuration.inMilliseconds + addMilliseconds;
    if (milliseconds < 0) {
      endTheMatch();
    } else {
      _blackDuration = Duration(milliseconds: milliseconds);
    }
    setBlackTime();
  }

  void setWhiteTime() {
    whiteTime =
        "${twoDigits(_whiteDuration.inHours % 24)}:${twoDigits(_whiteDuration.inMinutes % 60)}:${twoDigits(_whiteDuration.inSeconds % 60)}";
    update();
  }

  void setBlackTime() {
    blackTime =
        "${twoDigits(_blackDuration.inHours % 24)}:${twoDigits(_blackDuration.inMinutes % 60)}:${twoDigits(_blackDuration.inSeconds % 60)}";
    update();
  }

  void endTheMatch() {
    if (_whiteTimer != null && _whiteTimer!.isActive) _whiteTimer!.cancel();
    if (_blackTimer != null && _blackTimer!.isActive) _blackTimer!.cancel();
    bool whiteWins = _whiteDuration > _blackDuration;
    Get.delete<MatchController>();
    Get.offAndToNamed("/Statics", arguments: whiteWins);
  }

  initial() async {
    int minutes = Get.find<MainController>().minutes;
    int hours = Get.find<MainController>().hours;
    _whiteCountDownDuration = Duration(hours: hours, minutes: minutes);
    _blackCountDownDuration = Duration(hours: hours, minutes: minutes);
    _whiteDuration = Duration(hours: hours, minutes: minutes);
    _blackDuration = Duration(hours: hours, minutes: minutes);
    setWhiteTime();
    setBlackTime();
  }

  void returnToMainPage() {
    Get.offAndToNamed("/");
  }

  void pause() {
    if (_blackTimer != null && _blackTimer!.isActive) _blackTimer!.cancel();
    if (_whiteTimer != null && _whiteTimer!.isActive) _whiteTimer!.cancel();
    if (_gameStarted) _gamePaused = true;
    update();
  }

  void reset() {
    _gameStarted = false;
    _gamePaused = false;
    _isWhiteTurn = false;
    _blackDuration = _blackCountDownDuration;
    _whiteDuration = _whiteCountDownDuration;
    setBlackTime();
    setWhiteTime();
    pause();
  }

  @override
  void onInit() {
    initial();
    super.onInit();
  }

  @override
  void dispose() {
    if (_whiteTimer != null && _whiteTimer!.isActive) _whiteTimer!.cancel();
    if (_blackTimer != null && _blackTimer!.isActive) _blackTimer!.cancel();
    super.dispose();
  }
}
