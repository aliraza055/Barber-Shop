import 'package:barber_shop/pages/admin_order.dart';
import 'package:barber_shop/pages/home_page.dart';
import 'package:barber_shop/pages/user_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavigtionBa extends StatefulWidget {
  const NavigtionBa({super.key});

  @override
  State<NavigtionBa> createState() => _NavigtionBaState();
}
class _NavigtionBaState extends State<NavigtionBa> {
  int _index = 0;
  final List<Widget> _page = [
    HomePage(),
    AdminOrder(),
    UserProfile(),
  ];

 final items = <Widget>[
  Icon(Icons.home_filled, size: 30, color: Colors.black),
  Icon(Icons.calendar_month_rounded, size: 30, color: Colors.black),
  Icon(Icons.person_3_rounded, size: 30, color: Colors.black),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _page[_index],
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        items: items,
        height: 60,
        color: Colors.white,
        buttonBackgroundColor: Colors.white, 
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}