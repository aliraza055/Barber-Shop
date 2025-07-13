import 'package:flutter/material.dart';

class AdminOrder extends StatefulWidget {
  const AdminOrder({super.key});

  @override
  State<AdminOrder> createState() => _AdminOrderState();
}

class _AdminOrderState extends State<AdminOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Orders"),
      ),
      body: Container(
        color: Colors.black12,
        margin: EdgeInsets.only(left: 30,right: 30,top: 20),
        child: Column(children: [
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                Image.asset('assets/cutting.png'),

              ],
            ),
          )
        ],),
      ),
    );
  }
}