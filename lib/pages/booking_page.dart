import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
 final String name;
 const BookingPage({super.key,required this.name});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? today;
  TimeOfDay? currenttime;
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
)
,
            SizedBox(height: 20,),
           
            Image.asset('assets/discount.png',height: 100,width: double.infinity,fit: BoxFit.cover,),
             //SizedBox(height: 40,),
          
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
                           "${today!.day}-${today!.month}-${today!.year}" : "1-1-2001"
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
                          '${currenttime!.format(context).toString()}': '00:00',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                        
                      ],
                    ),
                    
              
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text("Book Now",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            )

        ],
      ),
     ),
    );
  }
}