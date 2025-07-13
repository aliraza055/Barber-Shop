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
        child: Container(
          margin: EdgeInsets.only(left: 30,right: 30,top: 20),
          child: Column(children: [
            Container(
            padding: EdgeInsets.all(8),
              height: 60,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/cutting.png',width: 50,height: 50,),
                  ],
                ),
              ),
            )
          ],),
        ),
      ),
    );
  }
}