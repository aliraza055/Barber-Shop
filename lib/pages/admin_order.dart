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
  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Color(0xFFF9F9F9), // soft off-white background
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/cutting.png', width: 60, height: 60),
              SizedBox(height: 8),
              Text(
                "Cutting",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Name: Ali Raza Maqbool",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
          
                  SizedBox(height: 4),
                  Text(
                    "Date: 22/3/2025",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    "Time: 7:12 PM",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    
      Center(
        child: Container(
          margin: EdgeInsets.only(top: 8),
         width: 60,
        padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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