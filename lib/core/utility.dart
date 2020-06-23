import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stack_trace/stack_trace.dart';

bool isNullOrEmpty(dynamic object) {
  if (object == null) {
    return true;
  }
  if (object is String) {
    return object.trim().isEmpty;
  }
  if (object is Iterable) {
    return object.isEmpty;
  }
  if (object is Map) {
    return object.isEmpty;
  }
  return false;
}

void lg(Object object, {int frames = 1}) {
  final output = "${Trace.current().frames[frames].location} | $object";
  final pattern = RegExp('.{1,1000}');
  pattern.allMatches(output).forEach((match) => debugPrint(match.group(0)));
}

class Utility {
  static String formatPrice(dynamic number) {
    final oCcy = NumberFormat("#,###", "en_US");
    if (number is String) {
      if (number.toString().isNotEmpty) {
        final int value = int.parse(number);

        return oCcy.format(value);
      } else {
        return '';
      }
    } else {
      return oCcy.format(number);
    }
  }
}
