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
                  if(value == null || value.isNotEmpty ){
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
                  if(value == null || value.isNotEmpty ){
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
                  controller: _semContr,
                validator: (value) {
                  if(value == null || value.isNotEmpty ){
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
              Container(
                height: 60,
                width: double.infinity,
                decoration:const BoxDecoration(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}