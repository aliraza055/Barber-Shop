import 'dart:convert';
import 'dart:io';

import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
      File? _image;
      User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _image == null ? Text("No image selected!") : Image.file(_image!,height: 200,width: 200,),
                      SizedBox(height: 20,),

          FloatingActionButton(
            child: Text("get"),
            onPressed: ()async{
          final currentImage=await ImagePicker().pickImage(source: ImageSource.gallery);
          if(currentImage != null){
            _image=File(currentImage.path);
            setState(() {
              
            });

          }
        
          }),
          SizedBox(height: 20,),
        FloatingActionButton(
            child: Text("upload"),
            onPressed: ()async{
          final uri=Uri.parse('https://api.cloudinary.com/v1_1/dhob4di7g/image/upload');
          final request=http.MultipartRequest('POST', uri);
          request.fields['upload_present']='upload_preset_file';
          request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
      final resposne=  await request.send();
      if(resposne.statusCode==200){
        final resBody=await resposne.stream.bytesToString();
        final decoede=jsonDecode(resBody);
        final imageurl=decoede['secure_url'];
        user!.updatePhotoURL(imageurl);
        await user!.reload();
      await FirebaseFirestore.instance.collection("Users").doc(user!.uid).update({
        'image':imageurl
      });
          ToastError().showToast(msg: "Uploaded Successfully!", color: Colors.black, textColor: Colors.white);
      }

          }),
          ],
        ),
      ),
    );
  }
}