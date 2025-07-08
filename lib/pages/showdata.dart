import 'package:barber_shop/pages/dialogbox.dart';
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
            Expanded(
              child: StreamBuilder(
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
                        return Card(
                          margin: EdgeInsets.only(top: 10),
                          child: 
                             Row(
                                  children: [
                                 Expanded(
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: ${docs[index]['name']}", style: TextStyle(fontSize: 20,),),
                                      Text("Roll no: ${docs[index]['Roll']}", style: TextStyle(fontSize: 20,)),
                                      Text("cgpa: ${docs[index]['cgpa']}", style: TextStyle(fontSize: 20,)),
                                                       
                                    ],
                                 ),
                                 ),
                                 GestureDetector(
                                  onTap: () {
                                    final doc=docs[index];
                        
                                    var _nameC=TextEditingController(text:doc["name"] );
                                    final _rollC=TextEditingController(text:doc["Roll"] );
                                    final _cgpaC=TextEditingController(text:doc["cgpa"] );

                                    showDialog(
                                      context: context,
                                      builder:(context){
                                        return Dialogbox(
                                          nameContr: _nameC, 
                                          rollContr: _rollC, 
                                          semContr: _cgpaC);
                                   }
                                      );
                                  },
                                   child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)
                                   
                                    ),
                                     child: Icon(Icons.delete)),
                                 ),
                                  Row(children: [
                                  Container(
                                  margin: EdgeInsets.only(left: 10),
                                   height: 50,
                                   width: 50,
                                   decoration: BoxDecoration(
                                   color: Colors.green,
                                    borderRadius: BorderRadius.circular(12)
                                   ), 
                                   child: Icon(Icons.edit))
                                 ],)
                          
                               ],
                             ),
                            
                          
                        );
              
                      });
                  }
                  return Text("No data found");
                }),
            )

          ],
        ),
      ),
    );
  }
}