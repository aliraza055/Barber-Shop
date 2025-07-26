import 'dart:convert';
import 'dart:io';

import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
File? image;
bool loading=false;
User? user=FirebaseAuth.instance.currentUser;

Future getimage()async{
  DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("UserImage").doc("").get();
  //Map<String, dynamic> data=snapshot.do

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image == null ? Text("no image selected") : Image.file(image!,height: 200,width: 200,),
            SizedBox(height: 100,),
            FloatingActionButton(onPressed: (){
              selectImage();
            },
            child:Text("select"),),
            SizedBox(height: 20,),
               FloatingActionButton(onPressed: (){
                sendImage();
            },
            child:loading ==true ? CircularProgressIndicator(): Text("select"),)
          ],
        ),
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
}}
Future<void> sendImage()async{
  if(image ==null){
        ToastError().showToast(msg: "select image", color: Colors.red, textColor: Colors.white);
return ;
  }
    setState(() {
      loading=true;
    });
  final url=Uri.parse('https://api.cloudinary.com/v1_1/dhob4di7g/image/upload');
  final request= http.MultipartRequest('POST', url);
  request.fields['upload_preset']='upload_preset_file';
  request.files.add(await http.MultipartFile.fromPath('file', image!.path));
  final respose=await request.send();
  if(respose.statusCode==200){
    final resBody=await respose.stream.bytesToString();
    final decode=jsonDecode(resBody);
    final _image=decode['secure_url'];
    print('resBody=$resBody');
    print("decode=$decode");
    print("image=$_image");
    final uid=randomAlphaNumeric(10);
    await FirebaseFirestore.instance.collection("UserImage").doc(uid).set({
      "uid":uid,
      "image":decode['secure_url']
    });
  
    ToastError().showToast(msg: "uploaded", color: Colors.green, textColor: Colors.white);
       setState(() {
      loading=false;
    });
  }else{
        ToastError().showToast(msg: '❌ Upload failed: ${respose.statusCode}',color: Colors.green,textColor: Colors.white);

  }
}

}