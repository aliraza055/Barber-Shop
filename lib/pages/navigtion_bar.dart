import 'package:barber_shop/pages/admin_order.dart';
import 'package:barber_shop/pages/home_page.dart';
import 'package:barber_shop/pages/sign_in.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavigtionBa extends StatefulWidget {
  const NavigtionBa({super.key});

  @override
  State<NavigtionBa> createState() => _NavigtionBaState();
}

class _NavigtionBaState extends State<NavigtionBa> {
  int _index=0;
  final List<Widget> _page=[
        HomePage(),
        AdminOrder(),
        SignIn()
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _page[_index],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value){
           setState(() {
             _index=value;
           });
        },
        items: [
         Icon(Icons.home_outlined,size: 30,),
        Icon(Icons.book_online),
        Icon(Icons.person_2_outlined)
      ]),
    );
  }
}