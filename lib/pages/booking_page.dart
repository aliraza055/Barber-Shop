import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/navigtion_bar.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class BookingPage extends StatefulWidget {
  final String name;
  final String image;
  const BookingPage({super.key, required this.name, required this.image});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  DateTime? today;
  TimeOfDay? currenttime;
  bool loading = false;

  sendOrder() async {
    try {
      String uid = randomAlphaNumeric(10);
      await FirebaseFirestore.instance.collection("UserOrder").doc(uid).set({
        "name": user!.displayName,
        "serviceImage": widget.image,
        "userUid": user!.uid,
        "userPhoto": user!.photoURL ?? ' ',
        "userContact": await SharedPreferece().getContact(),
        "gmail": user!.email,
        "services": widget.name,
        "date": "${today!.day}/${today!.month}/${today!.year}",
        "time": currenttime!.format(context).toString()
      });
      ToastError().showToast(
          msg: 'Your order added',
          color: Colors.green,
          textColor: Colors.white);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => NavigtionBa()));
    } catch (e) {
      ToastError().showToast(
          msg: 'Error${e.toString()}',
          color: Colors.red,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let’s the \nJourney Begin!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/discount.png',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
              const SizedBox(height: 30),
              _buildPickerBox(
                title: "Set Date",
                icon: Icons.calendar_today,
                value: today != null
                    ? "${today!.day}/${today!.month}/${today!.year}"
                    : "Choose date",
                onTap: () async {
                  DateTime? datepicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.utc(2026),
                  );
                  if (datepicked != null) {
                    setState(() {
                      today = datepicked;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildPickerBox(
                title: "Set Time",
                icon: Icons.access_time,
                value: currenttime != null
                    ? currenttime!.format(context).toString()
                    : "Choose time",
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.dialOnly,
                  );
                  if (time != null) {
                    setState(() {
                      currenttime = time;
                    });
                  }
                },
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () async => await sendOrder(),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                     gradient: LinearGradient(
                                colors: [Colors.deepPurple, Colors.indigo],
                              ),
                  ),
                  child: Center(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
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

  Widget _buildPickerBox(
      {required String title,
      required IconData icon,
      required String value,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.deepPurple),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800])),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
