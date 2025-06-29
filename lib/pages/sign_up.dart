import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
          padding: EdgeInsets.only(top: 70,left: 20),
          height: MediaQuery.of(context).size.height/3,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
        colors: [
          Colors.red,// Purple-ish red
            // Color(0xFF8E2DE2), 
            Colors.black
        ],
            )
          ),
          child: Text("Create Your \nAccount!",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        Container(
         // height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(
            color: Colors.white
          ),
        )
        

        ],
       
      ),
    );
  }
}