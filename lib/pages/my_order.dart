import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  User? user= FirebaseAuth.instance.currentUser;
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // same as HomePage
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("UserOrder").where('userUid', isEqualTo: user!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No orders yet!"));
            }

            final items = snapshot.data!.docs;

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final data = items[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: data['serviceImage'].toString().trim().isNotEmpty
                                ? AssetImage(data['serviceImage'])as ImageProvider
                                : const AssetImage('assets/download.png'),
                          ),
                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['services'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                          
                                const SizedBox(height: 4),
                             
                                Text(
                                  "Date: ${data['date']}",
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                                Text(
                                  "Time: ${data['time']}",
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
