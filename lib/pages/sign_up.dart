import 'package:barber_shop/pages/sign_in.dart';
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
          height: MediaQuery.of(context).size.height/2,
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
          padding: EdgeInsets.only(left: 24,top: 40,right: 24),
          margin: EdgeInsets.only(top: 200),
         // height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  prefixIcon: Icon(Icons.man)
                ),
              ),
                            SizedBox(height: 20,),

              Text("Gmail",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your Gmail",
                  prefixIcon: Icon(Icons.email)
                ),
              ),
                            SizedBox(height: 20,),

              Text("password",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.man)
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                width: MediaQuery.of(context).size.width,
                height:  50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Colors.red,
                    Colors.black87
                  ])
                ),
                child: Center(child: Text("SIGN UP",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
              ),
              SizedBox(height: 30,),
              Row(
              //  crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Already have an account?",textAlign:TextAlign.end,),
                  SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));
                },
                child: Text("Sign In",
                style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold)),
              )
                ],
              )
            ],
          )
        )
        

        ],
       
      ),
    );
  }
}