import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor:  Color(0xFF2B1B17),

     body: Container(
      margin: EdgeInsets.only(top: 30,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lets the \nJourney Begins!",
          style: TextStyle(
            color: Colors.white60,fontSize: 30,
            fontWeight: FontWeight.w400),),
                        SizedBox(height: 20,),
           Center(
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white24,  // border color
        width: 2.0,          // border thickness
        style: BorderStyle.solid, // solid line (default)
      ),
      borderRadius: BorderRadius.circular(10), // optional: rounded corners
    ),
    padding: EdgeInsets.all(10),
    child: Text(
      "Classic Shaving",
      style: TextStyle(
        color: Colors.white70,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
,
            SizedBox(height: 20,),
            Image.asset('assets/discount.png',height: 100,width: double.infinity,fit: BoxFit.cover,),

        ],
      ),
     ),
    );
  }
}