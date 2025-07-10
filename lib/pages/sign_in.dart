import 'package:barber_shop/model/auth.dart';
import 'package:barber_shop/pages/sign_up.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _keyform=GlobalKey<FormState>();
  final _gamilController=TextEditingController();
    final _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
          padding: EdgeInsets.only(top: 70,left: 20),
          height: MediaQuery.of(context).size.height/2,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
        colors: [
          Colors.red,
            Colors.black
        ],
            )
          ),
          child: Text(" Hello \n Sign In!",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.only(left: 24,top: 40,right: 24),
          margin: EdgeInsets.only(top: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
          ),
          child: Form(
            key: _keyform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    
                              SizedBox(height: 20,),
            
                Text("Gmail",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                     return "Enter your name";
                    }
                    return null;
                  },
                  controller: _gamilController,
                  decoration: InputDecoration(
                    hintText: "Enter your gmail",
                    prefixIcon: Icon(Icons.email)
                  ),
                ),
                              SizedBox(height: 20,),
            
                Text("password",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextFormField(
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be empty"; 
                    }
                    return null;
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(Icons.man)
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    if(_keyform.currentState!.validate()){
                      Auth().singIn(_gamilController.text, _passwordController.text);
                      
                    }
                  },
                  child: Container(
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
                    child: Center(child: Text("SIGN IN",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                //  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account?",textAlign:TextAlign.end,),
                    SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
                  },
                  child: Text("Sign Up",
                  style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold)),
                )
                  ],
                )
              ],
            ),
          )
        )
        

        ],
       
      ),
    );
  }
}