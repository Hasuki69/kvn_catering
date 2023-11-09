import 'package:flutter/material.dart';

Future<DateTime> datePicker(BuildContext context,
    {required DateTime selected, DateTime? firstDate}) async {
  var now = selected;

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: firstDate ?? DateTime(now.year),
    lastDate: DateTime(now.year + 1),
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    return now;
  }
}
