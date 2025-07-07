
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class FirebaseServices{
  Future<void> sendData(Map<String,dynamic> data)async{
  final uid=randomAlphaNumeric(10);
  FirebaseFirestore.instance.collection("UserCollection").doc(uid).set(
  data
  ).then((value){
  ToastError().showToast(msg: "Add", color: Colors.green, textColor: Colors.white);

  }).catchError((error){
  ToastError().showToast(msg: "Error${error.toString()}", color: Colors.red, textColor: Colors.white);
  });
  }
}