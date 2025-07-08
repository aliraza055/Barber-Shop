import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {
 TextEditingController  nameContr;
  TextEditingController  rollContr;
 TextEditingController  semContr;

   Dialogbox({super.key,required this.nameContr,required this.rollContr,required this.semContr});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Update Expense")),
      content: Column(children: [
        TextField(
          controller:semContr ,
        ),
         TextField(
          controller:rollContr ,
        ), TextField(
          controller:semContr ,
        ),
      ],),
      actions: [
        ElevatedButton(onPressed: (){

        }, child: Text("Yes")),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
        }, child: Text("Yes"))
      ],
    );
  }
}