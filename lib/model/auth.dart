import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/navigtion_bar.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Auth{
Future<void> singUp(BuildContext context,String name,String email,String password,final contact)async{
    try{
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password).then((value)async{

User? user=FirebaseAuth.instance.currentUser!;
        user.updateDisplayName(name);
        await SharedPreferece().sendContact(contact);
        await user.reload();
         Map<String,dynamic> userinfo={
          "Name":name,
          "Gmail":email,
          "Contact":contact,
          "image":''
       };
     await sendData(user.uid, userinfo);
        ToastError().showToast(msg: "Create account successfully!", color: Colors.green, textColor: Colors.white);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>NavigtionBa()),(route)=>false);
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
  Future<void> singIn(BuildContext context,String email,String password)async{
    try{
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){

     ToastError().showToast(msg: 'Login Successful!', color: Colors.green, textColor: Colors.white);
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>NavigtionBa()),(route)=>false);

    });
  } on FirebaseAuthException catch (e){
    if(e.code=='user-not-found'){
      ToastError().showToast(msg: 'User not found!', color: Colors.red, textColor: Colors.white);
    }else if(e.code=='wrong-password'){
          ToastError().showToast(msg: 'incorrect password',color:  Colors.red,textColor: Colors.white);
        }else{
          ToastError().showToast(msg: 'Error:${e.message}',color:  Colors.red,textColor: Colors.white);
              }
    } catch (e){
                ToastError().showToast(msg: 'Unexpected error',color:  Colors.red,textColor: Colors.white);

    }

  }
    }

  Future<void> sendData(String id,Map<String,dynamic> userinfo) async{
     await  FirebaseFirestore.instance.collection("Users").doc(id).set(
     userinfo
    );
  }
