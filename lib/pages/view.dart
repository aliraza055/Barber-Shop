import 'package:flutter/material.dart';

class ViewExpnses extends StatefulWidget {
  const ViewExpnses({super.key});

  @override
  State<ViewExpnses> createState() => _ViewExpnsesState();
}

class _ViewExpnsesState extends State<ViewExpnses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Your Expsenses",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
)
          ],
        ),
      ),
    );
  }
}