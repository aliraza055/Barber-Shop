
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final amountC = TextEditingController();
  final categoryC = TextEditingController();
  final descriptionC = TextEditingController();
  final methodC = TextEditingController();
  final _keyform = GlobalKey<FormState>();

  @override
  void dispose() {
    amountC.dispose();
    categoryC.dispose();
    descriptionC.dispose();
    methodC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyform,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Column(
              children: [
                const Center(
                    child: Text(
                  "Expense tracker",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 30),
                TextFormField(
                  controller: amountC,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter  amount" : null,
                      keyboardType:TextInputType.number,
                  decoration: InputDecoration(
                    
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Enter  amount',
                    labelText: 'Amount',
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: categoryC,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter  Category" : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Category',
                    hintText: 'Enter  Category',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: descriptionC,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter  Description" : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Description',
                    hintText: 'Enter Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: methodC,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter Method" : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Payment Method',
                    hintText: 'Enter Payment Method',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    if (_keyform.currentState!.validate()) {
                      final uid = randomAlphaNumeric(10);
                      FirebaseFirestore.instance
                          .collection("Expenses")
                          .doc(uid)
                          .set({
                        "amount": amountC.text,
                        "Category": categoryC.text,
                        "Description": descriptionC.text,
                        "Method": methodC.text
                      });
                      ToastError().showToast(
                          msg: "Add Expenses",
                          color: Colors.green,
                          textColor: Colors.white);
                      amountC.clear();
                      categoryC.clear();
                      descriptionC.clear();
                      methodC.clear();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.shade500,
                    ),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
