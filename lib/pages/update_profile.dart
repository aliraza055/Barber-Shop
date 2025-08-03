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
    backgroundColor: const Color(0xFFF5F5F5), // same as HomePage
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Update Profile",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // matched to HomePage style
              ),
            ),
            const SizedBox(height: 30),

            // Avatar with camera icon
            Stack(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _image == null
                      ? (user!.photoURL == null
                          ? const AssetImage('assets/download.png')
                          : NetworkImage(user!.photoURL!)) as ImageProvider
                      : FileImage(_image!),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (picked != null) {
                        setState(() {
                          _image = File(picked.path);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.indigo], // HomePage gradient
                        ),
                      ),
                      child: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),

            // Name field
            Align(alignment: Alignment.centerLeft, child: Text("Name", style: labelStyle())),
            const SizedBox(height: 8),
            textInput(nameContr!, "Enter name"),

            const SizedBox(height: 20),

            // Email field
            Align(alignment: Alignment.centerLeft, child: Text("Email", style: labelStyle())),
            const SizedBox(height: 8),
            textInput(gmailContr!, "Email", readOnly: true),

            const SizedBox(height: 20),

            // Contact field
            Align(alignment: Alignment.centerLeft, child: Text("Contact", style: labelStyle())),
            const SizedBox(height: 8),
            IntlPhoneField(
              controller: contactContr,
              initialCountryCode: 'PK',
              decoration: inputDecoration("Enter contact number"),
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

            // Update button with gradient
            GestureDetector(
              onTap: () async {
                if (contactContr!.text.isNotEmpty && gmailContr!.text.isNotEmpty) {
                  updateProfile();
                }
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo], // HomePage gradient
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: loading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : const Center(
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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


InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

Widget textInput(TextEditingController controller, String hint, {bool readOnly = false}) {
  return TextField(
    controller: controller,
    readOnly: readOnly,
   
    decoration: inputDecoration(hint),
    style: const TextStyle(fontSize: 16),
  );
}

TextStyle labelStyle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
}
}