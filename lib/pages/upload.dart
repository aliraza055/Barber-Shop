import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          image == null ? Text("no image selected") : Image.file(image!),
          FloatingActionButton(onPressed: (){

          },
          child: Text("select"),),
          SizedBox(height: 20,),
             FloatingActionButton(onPressed: (){

          },
          child: Text("select"),)
        ],
      ),
    );
  }
  Future selectImage()async{
  final  picker=ImagePicker();
final  slectedImage=await picker.pickImage(source: ImageSource.gallery);
if(slectedImage != null){
  image=File(slectedImage.path);
  setState(() {
    
  });
}

  }
}