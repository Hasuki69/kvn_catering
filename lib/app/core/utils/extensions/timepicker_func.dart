import 'package:flutter/material.dart';

Future<TimeOfDay> timePicker(BuildContext context,
    {required TimeOfDay selected}) async {
  var now = selected;

  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    initialEntryMode: TimePickerEntryMode.inputOnly,
  );

  if (pickedTime != null) {
    return pickedTime;
  } else {
    return now;
  }
}
