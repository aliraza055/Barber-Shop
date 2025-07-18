import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class BookingPage extends StatefulWidget {
 final String name;
 final String image;
 const BookingPage({super.key,required this.name,required this.image});

  @override
  State<BookingPage> createState() => _BookingPageState();
}
class _BookingPageState extends State<BookingPage> {
  DateTime? today;
  TimeOfDay? currenttime;
  String? nameK;
  String? gmal;
   Future<void> loadUserData() async {
    nameK = await SharedPreferece().getName();
    gmal = await SharedPreferece().getGmail();
    setState(() {}); 
  }
  sendOrder()async{
    try{
      String uid=randomAlphaNumeric(10);
   await FirebaseFirestore.instance.collection("UserOrder").doc(uid).set({
      "name":nameK,
      "serviceImage":widget.image,
      "gmail":gmal,
      "services":widget.name,
      "date":"${today!.day}/${today!.month}/${today!.year}",
      "time":  currenttime!.format(context).toString()
    });
    ToastError().showToast(msg: 'Your order added', color: Colors.green, textColor: Colors.white);
    }catch(e){
      ToastError().showToast(msg: 'Error${e.toString()}', color: Colors.red, textColor: Colors.white);
    }
  }
  @override
  void initState()  {
loadUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor:  Color(0xFF2B1B17),

     body: Container(
      margin: EdgeInsets.only(top: 50,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lets the \nJourney Begins!",
          style: TextStyle(
            color: Colors.white60,fontSize: 30,
            fontWeight: FontWeight.w400),),
                        SizedBox(height: 20,),
           Center(
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white24,  // border color
        width: 2.0,          // border thickness
        style: BorderStyle.solid, // solid line (default)
      ),
      borderRadius: BorderRadius.circular(10), // optional: rounded corners
    ),
    padding: EdgeInsets.all(10),
    child: Text(
      widget.name,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

            SizedBox(height: 20,),         
            Image.asset('assets/discount.png',height: 100,width: double.infinity,fit: BoxFit.cover,),          
            GestureDetector(
              onTap: ()async{
                DateTime? datepicked=await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(), 
                  lastDate: DateTime.utc(2026));
                if(datepicked !=null){
                  setState(() {
                    today=datepicked;
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.only(top: 10),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber.shade200
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text("Set Date",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: 5,),
                        Text(  today != null?
                           "${today!.day}/${today!.month}/${today!.year}" : "1-1-2001"
                          ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),      
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            GestureDetector(
              onTap: ()async{
                TimeOfDay? time=await showTimePicker(
                  context: context, 
                  initialTime: TimeOfDay.now(),
                  initialEntryMode: TimePickerEntryMode.dialOnly
                  );
                  if(time != null){
                    setState(() {
                    currenttime=time;
                    });
                  }
                  
              },
              child: Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.only(top: 10),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber.shade200
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text("Set Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_clock),
                        SizedBox(width: 10),
                        Text( currenttime !=null ?
                          currenttime!.format(context).toString() : '12:00 pm',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)                       
                      ],
                    ),             
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()async{
            await sendOrder();
              },
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text("Book Now",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            )
        ],
      ),
     ),
    );
  }
}