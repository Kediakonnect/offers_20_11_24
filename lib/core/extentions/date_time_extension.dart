import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate {
    return '$day/$month/$year';
  }

  String get formattedDate2 {
    return DateFormat('d MMMM, yyyy').format(this);
  }

  static DateTime? parseFormattedDate(String formattedDate) {
    try {
      final parts = formattedDate.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      // Handle any parsing errors
    }
    return null;
  }
}

extension DateTimeExtension2 on TimeOfDay {
  String formatToAmPm() {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat.jm().format(dateTime);
  }

  static TimeOfDay? parseFormattedAmPm(String formattedTime) {
    try {
      final dateTime = DateFormat.jm().parse(formattedTime);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (e) {
      // Handle any parsing errors
    }
    return null;
  }
}
