import 'dart:convert';
import 'dart:io';

import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UpdateProfile extends StatefulWidget {
String contact;
   UpdateProfile({super.key,required this.contact});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
   bool loading=false;
      File? _image;
      User? user=FirebaseAuth.instance.currentUser;
  TextEditingController? nameContr;
  //TextEditingController gmailContr=TextEditingController(user!.email!)
  TextEditingController? gmailContr;
    TextEditingController? contactContr;

 Future uploadImage()async{
  final uri=Uri.parse('uri');
  final request=http.MultipartRequest('POST', uri);
  request.fields['upload_preset']= 'upload_preset_file';
  request.files.add(await http.MultipartFile.fromPath('file', _image!.path));
 final res= await request.send();
 if(res.statusCode==200){
  final resBody=await res.stream.bytesToString();
  final decoded=jsonDecode(resBody);
  final image=decoded['secure_url'];
 await user!.updatePhotoURL(image);
 }
 }

      @override
  void initState() {
    nameContr=TextEditingController(text: user!.displayName);
    gmailContr=TextEditingController(text: user!.email);
    contactContr=TextEditingController(text: widget.contact);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                   CircleAvatar(
                radius: 60,
                
                backgroundImage:_image == null ? user!.photoURL == null ?
                 AssetImage('assets/download.png'): NetworkImage(user!.photoURL!) : FileImage(_image!),
                   ),
                 Positioned(
                  bottom: -1,
                  right: 4,
                   child: GestureDetector(
                    onTap: ()async{
                    final selectImage=await ImagePicker().pickImage(source: ImageSource.gallery);
                    if(selectImage != null){
                      setState(() {
                        _image=File(selectImage.path);
                      });
        
                    }
                    },
                     child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle
                      ),
                      padding: EdgeInsets.all(6),
                      child:Icon(Icons.edit) ,
                                  ),
                   ),
                 ),
        
                ],
              ),
                             SizedBox(height: 30,),
                             TextField(
                           controller: nameContr ,
                             ),
                             
                             SizedBox(height: 30,),
                             TextField(
                           controller: gmailContr ,
                             ),
                             SizedBox(height: 30,),
                             IntlPhoneField(
                              initialCountryCode: 'PK',
                              controller: contactContr,
                             ),
                           
                                SizedBox(height: 30,),
        
              ElevatedButton(onPressed: ()async{
                if(nameContr.text.toString() && )
              uploadImage();
              user!.updateDisplayName(nameContr!.text);
         await SharedPreferece().sendContact(contactContr!.text);
        
              }, child: Text("Upagate"))
        
            ],
          ),
        ),
      ),
    );
  }
  void fun(){
    
          FloatingActionButton(
            child: Text("get"),
            onPressed: ()async{
          final currentImage=await ImagePicker().pickImage(source: ImageSource.gallery);
          if(currentImage != null){
            _image=File(currentImage.path);
            setState(() {
              
            });

          }
        
          });
          SizedBox(height: 20,);
        FloatingActionButton(
            child:loading ? CircularProgressIndicator(): Text("upload"),
            onPressed: ()async{
              setState(() {
                loading=true;
              });
          final uri=Uri.parse('https://api.cloudinary.com/v1_1/dhob4di7g/image/upload');
          final request=http.MultipartRequest('POST', uri);
          request.fields['upload_preset']='upload_preset_file';
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
   final snapshot=  await FirebaseFirestore.instance.collection("UserOrder").where('userUid', isEqualTo: user!.uid).get();
   if(snapshot.docs.isNotEmpty){
     for(var doc in snapshot.docs){
      await doc.reference.update({
        'userPhoto':imageurl
      });
     }
   }
          ToastError().showToast(msg: "Uploaded Successfully!", color: Colors.black, textColor: Colors.white);
          
      }else{
                  ToastError().showToast(msg: "${resposne.statusCode}", color: Colors.black, textColor: Colors.white);

      }

          });
  }
}