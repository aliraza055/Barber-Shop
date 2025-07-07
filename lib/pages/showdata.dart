import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Showdata extends StatefulWidget {
  const Showdata({super.key});

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40,left: 20,right: 20),
        child: Column(
          children: [
            Text(
           'All Students record',
           style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),

            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("UserCollection").snapshots(), 
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  Center(child: CircularProgressIndicator(strokeWidth: 2,));
                }
                if(snapshot.hasError){
                  ToastError().showToast(msg: "unexpected error", color: Colors.red, textColor: Colors.white);
                }
                if(snapshot.hasData){
                  List docs=snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Column(
                          children: [
                            Text("Name: ${docs[index]['name']}"),
                        
                          ],

                        ),
                      );

                    });
                }
                return Text("No data found");
              })

          ],
        ),
      ),
    );
  }
}