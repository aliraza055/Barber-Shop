import 'package:barber_shop/pages/admin_order.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
 final _keyform=GlobalKey<FormState>();
  final _gamilController=TextEditingController();
    final _passwordController=TextEditingController();
    bool loading =false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
          padding: EdgeInsets.only(top: 70,left: 20),
          height: MediaQuery.of(context).size.height/2,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
        colors: [
          Colors.green.shade900,
          Colors.green.shade900,
        ],
            )
          ),
          child: Text(" Admin \n Log In!",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.only(left: 24,top: 40,right: 24),
          margin: EdgeInsets.only(top: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
          ),
          child: Form(
            key: _keyform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    
                              SizedBox(height: 20,),
            
                Text("Gmail",style: TextStyle(color: Colors.green.shade900,fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                     return "Enter your name";
                    }
                    return null;
                  },
                  controller: _gamilController,
                  decoration: InputDecoration(
                    hintText: "Enter your gmail",
                    prefixIcon: Icon(Icons.email)
                  ),
                ),
                              SizedBox(height: 20,),
            
                Text("password",style: TextStyle(color: Colors.green.shade900,fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextFormField(
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be empty"; 
                    }
                    return null;
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(Icons.password_outlined)
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    if(_keyform.currentState!.validate()){
                      setState(() {
                        loading=true;
                      });
                  login();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    height:  50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(colors: [
                        Colors.green.shade900,
                        Colors.blue.shade900
                      ])
                    ),
                    child:loading ? Center(child: CircularProgressIndicator(color: Colors.white,)): Center(child: Text("LOG IN",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
                
              ],
            ),
          )
        )
        

        ],
       
      ),
    );
  }
  login()async{
      await FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
        for(var result in snapshot.docs){
          if(result.data()['id'] != _gamilController.text.trim()){
            ToastError().showToast(msg: "You have enter wrong user name", color: Colors.red, textColor: Colors.white);
          }
          else if(result.data()["password"] != _passwordController.text.trim()){
                        ToastError().showToast(msg: "You have enter wrong user password", color: Colors.red, textColor: Colors.white);

          }else{
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminOrder()));
          }
        }
        
      }
     );
      }
}
