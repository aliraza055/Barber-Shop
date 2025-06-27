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
     body: Container(
      margin: EdgeInsets.only(top: 30,left: 20),
      child: Column(
        children: [
          Text("Lets the \n Journey Begins",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),)
        ],
      ),
     ),
    );
  }
}