import 'package:barber_shop/pages/home_page.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
class Auth{
Future<void> singUp(BuildContext context,String name,String email,String password)async{
    try{
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password).then((value){
        String uid=randomAlphaNumeric(10);
        Map<String,dynamic> userinfo={
          "Name":name,
          "Gmail":email
        };
        ToastError().showToast(msg: "Create account successfully!", color: Colors.green, textColor: Colors.white);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
      });
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password') {
      ToastError().showToast(msg: "Your password is weak!", color: Colors.red, textColor: Colors.white);
    }
    else if(e.code == 'email-already-use-in'){
       ToastError().showToast(msg: "This email is already used!", color: Colors.red, textColor: Colors.white);
    } else{
        ToastError().showToast(msg: 'Error:${e.message}', color: Colors.red, textColor: Colors.white);
    }
    } catch (e){
     ToastError().showToast(msg: 'An unexpected error', color: Colors.red, textColor: Colors.white);
    }

  }
  Future<void> sendData(String id,Map<String,dynamic> userinfo) async{
     await  FirebaseFirestore.instance.collection("Users").doc(id).set(
     userinfo
    );
  }
}