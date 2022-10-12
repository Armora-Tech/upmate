import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

bool compare(
  String one,
  String two,
) {
  // Add your function code here!
  if (int.parse(one) == int.parse(two)) {
    return true;
  } else {
    return false;
  }
}

String? joinLString(
  List<String> str,
  String separator,
) {
  // Add your function code here!
  String finalstr = str.join(separator);
  return finalstr;
}
