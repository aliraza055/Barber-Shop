import 'package:barber_shop/pages/sign_up.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            Image.asset("assets/cutting.png",height: 200,width: 200,), 
             Text('Welcome to',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),                     
            Text(' SallonX',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),                   
            SizedBox(height: 50,),
           GestureDetector
           (
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUp()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo], // HomePage gradient
                  ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
              ],
            ),
            child: Text(
              "Get a Stylish Haircut",
              style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
              ),
            ),
          ),
        )
          ],
        ),
      ),
    );
  }
}