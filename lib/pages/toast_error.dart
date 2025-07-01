import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastError{
  void showToast(String msg,Color color,Color textColor){
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: textColor
      );
  }
}