import 'dart:convert';
import 'dart:io';

import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/navigtion_bar.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UpdateProfile extends StatefulWidget {
final contact;
 const  UpdateProfile({super.key,required this.contact});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
   bool loading=false;
      File? _image;
      User? user=FirebaseAuth.instance.currentUser;
  TextEditingController? nameContr;
  TextEditingController? gmailContr;
    TextEditingController? contactContr;


 Future updateProfile() async {
  setState(() {
    loading=true;
  });
  if (_image != null) {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/dhob4di7g/image/upload');
    final request = http.MultipartRequest('POST', uri);
    request.fields['upload_preset'] = 'upload_preset_file';
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    final res = await request.send();
    if (res.statusCode == 200) {
      final resBody = await res.stream.bytesToString();
      final decoded = jsonDecode(resBody);
      final image = decoded['secure_url'];

      await _updateFirebase(image);
       ToastError().showToast(
          msg: "Update Successfully!",
          color: Colors.green,
          textColor: Colors.white);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>NavigtionBa()));
    } else {
      ToastError().showToast(
          msg: "Error:${res.statusCode}",
          color: Colors.red,
          textColor: Colors.white);
    }
  } else {
    // Image nahi change ki → Sirf name/contact update
    await _updateFirebase(user!.photoURL);
    ToastError().showToast(
          msg: "Update Successfully!",
          color: Colors.green,
          textColor: Colors.white);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>
                    NavigtionBa()));

  }
}

Future _updateFirebase(String? imageUrl) async {
  await user!.updatePhotoURL(imageUrl);
  await user!.updateDisplayName(nameContr!.text);
  await user!.reload();

  await SharedPreferece().sendContact(contactContr!.text);

  await FirebaseFirestore.instance.collection("Users").doc(user!.uid).update({
    'Name': nameContr!.text,
    'Contact': contactContr!.text,
    'image': imageUrl ?? '',
  });
 QuerySnapshot snapshot= await FirebaseFirestore.instance.collection("UserOrder").where('userUid', isEqualTo:user!.uid ).get();
 if(snapshot.docs.isNotEmpty){
  for(var doc in snapshot.docs){
    doc.reference.update({
      'userPhoto':imageUrl ?? " ",
      "name": nameContr!.text,
      'userContact':contactContr!.text
    });
  }

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
      resizeToAvoidBottomInset: false,
      body: Container(
                  color: Colors.black12,

        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Update Profile",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
              SizedBox(height: 30,),
              Center(
                child: Stack(
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
                        child:Icon(Icons.add) ,
                                    ),
                     ),
                   ),
                      
                  ],
                ),
              ),
                             SizedBox(height: 10,),
                                Text( 'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
                             TextField(
                           controller: nameContr ,
                           showCursor: true,
                           decoration: InputDecoration(
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                              
                            )
                           ),
                             ),
                             
                             SizedBox(height: 20,),
                             Text("Gmail",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
SizedBox(height: 10,),
                             TextField(
                           controller: gmailContr ,
                           decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                           ),
                           readOnly: true,
                             ),
                             SizedBox(height: 20,),
                             Text("Contact", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                             SizedBox(height: 10,),
                             IntlPhoneField(
                              initialCountryCode: 'PK',
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)
                                )
                              ),
                              controller: contactContr,
                             ),
                           
                                SizedBox(height: 30,),
                                GestureDetector(
                                  onTap: ()async{
                if(contactContr!.text.isNotEmpty && gmailContr!.text.isNotEmpty){
                updateProfile();           
                }           
              },
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                      color: Colors.blue,
                                     borderRadius: BorderRadius.circular(12)

                                      ),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child:loading ? Center(child: CircularProgressIndicator(color: Colors.white,)) :
                                      Center(child: Text('Update',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)) ,),
                                  ),
                                )
                    
                    
            ],
          ),
        ),
      ),
    );
  }
}