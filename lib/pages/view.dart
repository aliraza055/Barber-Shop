import 'package:barber_shop/pages/reg.dart';
import 'package:barber_shop/pages/toast_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      color: Colors.black12,       
        child: Container(
          margin: EdgeInsets.only(top: 50,left: 30,right: 30),
          child: Column(
            children: [
              Center(
                child: Text("Your Expsenses",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Expenses").snapshots(),
                 builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                   return Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasError){
                   ToastError().showToast(msg: "Thre is error", color: Colors.white, textColor: Colors.red);
                  }if(snapshot.hasData){
                    final doc=snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: doc.length,
                      itemBuilder: (context,index){
                        final docID=doc[index].id;
                        return Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                              color: Colors.white,
                             borderRadius: BorderRadius.circular(12),
                           boxShadow: [
                           BoxShadow(
                           color: Colors.grey.withOpacity(0.3),
                           blurRadius: 5,
                             offset: Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amount: ${doc[index]['amount']}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Category: ${doc[index]['Category']}",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 4),
          Text(
            "Method: ${doc[index]['Method']}",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Text(docID)
        ],
      ),
      Row(
        children: [
            GestureDetector(
              onTap: (){
                FirebaseFirestore.instance.collection("Expenses").doc(docID).delete();
              },
              child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      height: 40,
                      width: 40,
                      child: Icon(Icons.delete),),
            ),
        GestureDetector(
          onTap: (){
            final docs=doc[index];
            showDialog(context: context, builder: (context){
              final amountCon=TextEditingController(text: docs["amount"]);
              final categoryCon=TextEditingController(text:docs["Category"]);
              return AlertDialog(
                title: Text("Update Expense"),
                content: Column(
                  children: [
                    TextField(
                      controller: amountCon,
                    ),
                    TextField(
                      controller: categoryCon,
                    )
                  ],
                ),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: Text("NO")),
                   TextButton(onPressed: (){
                    FirebaseFirestore.instance.collection('Expenses').doc(docs.id).update({
                      "amount":amountCon.text,
                      "Category":categoryCon.text
                    }).then((value){
                      ToastError().showToast(msg: "Update Successfuly!", color: Colors.green, textColor: Colors.white);
                     Navigator.pop(context);
                    }).catchError((error){        
                      ToastError().showToast(msg: "Error${error.toString()}", color: Colors.red, textColor: Colors.white);
                      Navigator.pop(context);
                    });
                  }, child: Text("Yes"))
                ],
              );
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12)
          ),
          height: 40,
          width: 40,
          child: Icon(Icons.edit),),
        )
        ],
      )    
    ],
  ),
);                
                      });
                  }
                     else {
                      return Center(child: Text("No expenses found"));
                    }          
                 }
                 ),
              )
            ],
          ),
        ),
      ),
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
         child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Registration()));
        }
        ),
    );
  }
}