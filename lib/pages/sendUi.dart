import 'package:barber_shop/pages/firebase_services.dart';
import 'package:barber_shop/pages/showdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyTodo extends StatefulWidget {
  const MyTodo({super.key});

  @override
  State<MyTodo> createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  final _keyform=GlobalKey<FormState>();
  final _nameContr=TextEditingController();
    final _rollContr=TextEditingController();
  final _semContr=TextEditingController();
  @override
  void dispose() {
    _nameContr.dispose();
    _rollContr.dispose();
    _semContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text("Add New Data"),
        centerTitle: true,
      ),
      body: Form(
        key: _keyform,
        child: Container(
          margin:const EdgeInsets.only(top: 40,left: 20,right: 20),
          child: Column(
            children: [
              TextFormField(
                controller: _nameContr,
                validator: (value) {
                  if(value == null || value.isEmpty ){
                    return "This field can't be null";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  hint:const Text("Add name")
                ),            
              ),
             const SizedBox(
                height: 30,
              ),
                TextFormField(
                  controller: _rollContr,
                validator: (value) {
                  if(value == null || value.isEmpty ){
                    return "This field can't be null";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  hint:const Text("Add roll no")
                ),            
              ),
             const SizedBox(
                height: 30,
              ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  controller: _semContr,
                validator: (value) {
                  if(value == null || value.isEmpty ){
                    return "This field can't be null";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  hint:const Text("Add sgpa")
                ),            
              ),
             const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
                  Map<String,dynamic> data={
                    "name":_nameContr.text,
                    "Roll":_rollContr.text,
                    "cgpa":_semContr.text,
                    "timeStamp":Timestamp.now()
                  };
                  if(_keyform.currentState!.validate()){
                    FirebaseServices().sendData(data);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Showdata()));
                  }
                    

                  
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: 
                    [
                      Colors.blue,
                      Colors.green
                    ]
                    )
                  ),
                  child:const Center(
                    child: Text(
                      "Add",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}