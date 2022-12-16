import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
}

Widget showText(String message, [Color? color, double? size]) {
  return Text(
    message,
    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: size),
  );
}
