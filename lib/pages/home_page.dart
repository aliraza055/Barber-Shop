import 'package:barber_shop/model/services_model.dart';
import 'package:barber_shop/model/shared_preferece.dart';
import 'package:barber_shop/pages/booking_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName= " ";
  getName()async{
userName= await SharedPreferece().getName();
setState(() {
  
});

  }
  List<ServicesModel> services=[];
  @override
  void initState() {
    super.initState();
    getName();
    services=ServicesModel.getServices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10,left: 20,right: 20),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello!",style: TextStyle(color: Colors.black),),
                       Text(userName,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                  
                    ],
                  ),
                ),
                Image.asset('assets/boy.jpg',height: 50,width: 50,)
              ],
            ),
            SizedBox(height: 10,),
            Divider(),
           SizedBox(height: 10,),
             Text("Services",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
           SizedBox(height: 20,),
           Expanded(
             child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3/4,
                ),
              itemCount: services.length,
               itemBuilder: (context, index){
                return  GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>BookingPage(name: services[index].name,image: services[index].image,)));
                },
                 child: Container(
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
                      Image.asset(services[index].image,height: 70,width: 70,),
                                 SizedBox(height: 10,),
                 
                 Text(services[index].name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
  

                 
                      
                    ],
                  )
                 ),
               );
             
               }),
           )  
          
            
          ],
        ),
      ),
     
    );
  }
}