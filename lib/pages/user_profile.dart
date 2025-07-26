import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        FloatingActionButton(
          child: Text("get"),
          onPressed: (){

        }),
        SizedBox(height: 20,),
FloatingActionButton(
          child: Text("upload"),
          onPressed: (){

        }),
        ],
      ),
    );
  }
}