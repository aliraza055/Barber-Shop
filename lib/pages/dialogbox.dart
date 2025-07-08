import 'package:barber_shop/pages/firebase_services.dart';
import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {
 TextEditingController  nameContr;
  TextEditingController  rollContr;
 TextEditingController  semContr;
 String uid;

   Dialogbox({super.key,required this.nameContr,required this.rollContr,required this.semContr,required this.uid});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Update Expense")),
      content: Column(children: [
        TextField(
          controller:nameContr ,
        ),
         TextField(
          controller:rollContr ,
        ), TextField(
          controller:semContr ,
        ),
      ],),
      actions: [
        ElevatedButton(onPressed: (){
            Navigator.pop(context);

        }, child: Text("No")),
          ElevatedButton(
            onPressed: ()async{
            Navigator.pop(context);
              Map<String,dynamic> updateData={
                "name" :nameContr.text,
                "Roll": rollContr.text,
                "cgpa":semContr.text
              };
          await    FirebaseServices().update(updateData, uid);
                  },               
                  child: Text("Yes"))
      ],
    );
  }
}