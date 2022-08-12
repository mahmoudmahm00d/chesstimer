import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  int _minutes = 3;
  int _hours = 0;
  int get minutes => _minutes;
  int get hours => _hours;

  late Timer playerOne;
  late Timer playerTwe;
  String matchTime = "00h:03m";

  void fastOption(int minutes) {
    _minutes = minutes;
    _hours = 0;
    setMatchTime();
  }

  void setMatchTime() {
    matchTime =
        "${_hours.toString().padLeft(2, '0')}h:${_minutes.toString().padLeft(2, '0')}m";
    update();
  }

  showFlutterPicker(BuildContext context) {
    return Picker(
      adapter: NumberPickerAdapter(
        data: [
          const NumberPickerColumn(begin: 0, end: 10),
          const NumberPickerColumn(begin: 0, end: 59)
        ],
      ),
      hideHeader: true,
      selectedTextStyle: const TextStyle(fontWeight: FontWeight.w700),
      confirmText: 'Submit',
      title: const Center(
        child: Text('Select Time'),
      ),
      onConfirm: setSelectedValues,
    ).showDialog(context);
  }

  void setSelectedValues(Picker picker, List<int> values) {
    _minutes = (values[0] == 0 && values[1] < 3) ? 3 : values[1];
    _hours = values[0];
    setMatchTime();
  }
}
