import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastError{
  void showToast({required String msg,required Color color,required Color textColor}){
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: textColor,
                fontSize: 16.0,

      );
  }
}