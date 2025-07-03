import 'package:barber_shop/pages/reg.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewExpnses extends StatefulWidget {
  const ViewExpnses({super.key});

  @override
  State<ViewExpnses> createState() => _ViewExpnsesState();
}

class _ViewExpnsesState extends State<ViewExpnses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 30,right: 30),
        child: Column(
          children: [
            Center(
              child: Text("Your Expsenses",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Expenses").snapshots(),
               builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                 return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                 ToastError().showToast(msg: "Thre is error", color: Colors.white, textColor: Colors.red);
                }if(snapshot.hasData){
                  final doc=snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          children: [
                     Text(doc[index]['amount']),

                          ],
                        ),
                      );
                        
                      
                  
                    });
                }
                   else {
                    return Center(child: Text("No expenses found"));
                  }          
               }
               ),
            )
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
         child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Registration()));
        }
        ),
    );
  }
}