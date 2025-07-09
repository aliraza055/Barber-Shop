import 'package:barber_shop/pages/home_page.dart';
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
      body: Container(
        color:  Color(0xFF2B1B17),
        child: Column(
          children: [ 
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image.asset("assets/barber.png",),
            ),
            SizedBox(height: 50,),
           GestureDetector
           (
  onTap: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUp()));
  },
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    decoration: BoxDecoration(
      color: Colors.orange,
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