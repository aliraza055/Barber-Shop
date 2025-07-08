
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
  Future <void> update(Map<String ,dynamic> data,String uid)async{
    await FirebaseFirestore.instance.collection("UserCollection").doc(uid).update(data).then((value){
ToastError().showToast(msg: 'Updated succeffuly!', color: Colors.green, textColor: Colors.white);

    }).catchError((e){
ToastError().showToast(msg: 'e${e.toString()}', color: Colors.red, textColor: Colors.white);
    });
  }
  Future<void> delete(String id)async{
await FirebaseFirestore.instance.collection("UserCollection").doc(id).delete().then((value){
ToastError().showToast(msg: 'Updated Deleted!', color: Colors.green, textColor: Colors.white);
}).catchError((e){
ToastError().showToast(msg: 'e${e.toString()}', color: Colors.red, textColor: Colors.white);
});
  }
}