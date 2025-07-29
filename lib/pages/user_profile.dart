import 'dart:ffi';
import 'dart:io';
import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  String? phoneNo;
 getPhone()async{
      phoneNo=await SharedPreferece().getContact();
      setState(() {
        
      });
 }

 @override
 void initState() {
    super.initState();
  
    getPhone();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Picture with Edit Button
              CircleAvatar(
                radius: 60,
                backgroundImage: user!.photoURL!= null ? NetworkImage(user!.photoURL!):
                 AssetImage('assets/download.png'),
              ),
             
              SizedBox(height: 20),

              // Profile Info Card
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileRow(Icons.person, "Name",'${user!.displayName}'),
                SizedBox(height: 20,),
                    Divider(),
                    _buildProfileRow(
                        Icons.email, "Email" ,' ${ user?.email}' ),
                                        SizedBox(height: 20,),

                    Divider(),
                    _buildProfileRow(Icons.phone, "Contact", "+92 ${phoneNo}"),
                                    SizedBox(height: 20,),

                  ],
                ),
              ),

              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateProfile()));
                },
                child: _button(color: Colors.amber, hText: 'Edit Profile',)),
              SizedBox(height: 12),
             _button(color: Colors.red, hText: 'logout',),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.grey[700],),
        ),
      ],
    );
  }
  Widget _button({required Color color,required String hText}){
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12)

      ),
      child: Center(child: Text(hText,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
    );
  }
}
