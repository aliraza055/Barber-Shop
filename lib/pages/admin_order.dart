import 'package:cloud_firestore/cloud_firestore.dart';
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
    body: Container(
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "All Orders",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("UserOrder").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("There may be some error!"));
                  }
                  if (snapshot.hasData) {
                    final items = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F9F9),
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
                                      CircleAvatar(                                      
                                        backgroundImage:items[index]['userPhoto'] != null&& items[index]['userPhoto'].toString().isNotEmpty ?
                                        NetworkImage(items[index]['userPhoto']) as ImageProvider:
                                         AssetImage(items[index]['serviceImage']  )as ImageProvider,),
                                      SizedBox(height: 8),
                                      Text(
                                       items[index]['services'],
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
                                            "Name:${items[index]['name']}",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Date: ${items[index]['date']}",
                                            style: TextStyle(fontSize: 14, color: Colors.black54),
                                          ),
                                          Text(
                                            "Time: ${items[index]['time']}",
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Done",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: Text("No Order yet!"));
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
