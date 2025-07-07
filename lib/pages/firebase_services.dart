
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class FirebaseServices{
  final uid=randomAlphaNumeric(10);
  Map<String,dynamic>? data;
  Future<void> sendData()async{
  FirebaseFirestore.instance.collection("UserCollection").doc(uid).set(
  data! 
  );
  ToastError().showToast(msg: "Add", color: Colors.red, textColor: Colors.white);
  }
}