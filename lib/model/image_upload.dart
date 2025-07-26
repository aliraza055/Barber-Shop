import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUpload {
      File? myImage;
      User? user=FirebaseAuth.instance.currentUser;
  Future<void> slectedImage()async{
    final instance=ImagePicker();
    final image=await instance.pickImage(source: ImageSource.gallery);
    if(image ==null){
      return;
    }else{
      myImage=File(image.path);
    }

  }
  Future<void> sendImage()async{
                  final url=Uri.parse('https://api.cloudinary.com/v1_1/dhob4di7g/image/upload');
    final request=http.MultipartRequest('POST', url);
    request.fields['upload_preset']='upload_preset_file';
    request.files.add(await http.MultipartFile.fromPath('file',myImage!.path));
  final respose=  await request.send();
    if(respose.statusCode==200){
      final resBody=await respose.stream.bytesToString();
      final decode=jsonDecode(resBody);
      final imageUrl=decode['secure_url'];
      user!.updatePhotoURL(imageUrl);
    await  user!.reload();
     await FirebaseFirestore.instance.collection("Users").doc(user!.uid).update({
       'image':imageUrl
     });
      // await FirebaseFirestore.instance.collection("UserImages").doc(user!.uid).set({
      //  "userimage":decode['secure_url']
      // });
    }

  }
}