
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({super.key});

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  File? image;
  final picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 20,right: 20),
        child: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image == null ? Text("No image selected") : Image.file(image!),
              SizedBox(height: 20,),
              
              FloatingActionButton(
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select image for gallery"),
                ),
                onPressed: ()async{
            final   pickedImage =await  picker.pickImage(source: ImageSource.gallery);
            if(pickedImage !=null){
              setState(() {
                    image=File(pickedImage.path);
                  });
            }
                
                }),
                SizedBox(height: 20,),
                 FloatingActionButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("upload image to cloudinary"),
                ),
                onPressed: (){}),
            ],
          ),
        ),
      ),
    );
  }
}