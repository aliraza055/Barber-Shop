import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:  Color(0xFF2B1B17),
      body: Container(
        margin: EdgeInsets.only(top: 60,left: 20,right: 20),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello!",style: TextStyle(color: Colors.white),),
                     Text("Ali Raza",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)

                  ],
                ),
                // Text("data",style: TextStyle(color: Colors.white))
                Image.asset('assets/barber.png',height: 50,width: 50,)
              ],
            ),
            SizedBox(height: 10,),
            Divider(),
           SizedBox(height: 10,),
             Text("Services",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
           SizedBox(height: 20,),  
             Container(
              padding: EdgeInsets.only(top: 20,left: 10,right: 10),
              margin: EdgeInsets.only(left: 10,right: 10),
              height: 150,
           //   width: 150,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
                
              ),
              child: Column(
                children: [
                  Image.asset('assets/barber.png',height: 70,width: 70,),
                             SizedBox(height: 10,),

             Text("Classic Shaving",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),

                  
                ],
              )
             )
          ],
        ),
      ),
    );
  }
}