
import 'dart:convert';
import 'dart:io';

import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
              image == null ? Text("No image selected") : Image.file(image!,height:150,width: double.infinity,),
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
                onPressed: ()async{

                  final url=Uri.parse('https://api.cloudinary.com/v1_1/dhob4di7g/image/upload');
                 final request=http.MultipartRequest("POST", url);
                 request.fields["upload_preset"]='upload_preset_file';
                 request.files.add(await http.MultipartFile.fromPath('file', image!.path));
                 final response = await request.send();              

if (response.statusCode == 200) {
  final responseBody = await response.stream.bytesToString();
final decoded = jsonDecode(responseBody);
final imageUrl = decoded["secure_url"];  

  ToastError().showToast(msg: '✅ Upload successful: $responseBody',color: Colors.green,textColor: Colors.white);
} else {
    ToastError().showToast(msg: '❌ Upload failed: ${response.statusCode}',color: Colors.green,textColor: Colors.white);

}

                }),
            ],
          ),
        ),
      ),
    );
  }
}