
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wow_food_user_app/assistanceMethods/assistance_methods.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/main_screens/home_screen.dart';
class PlacedOrderScreen extends StatefulWidget {

  final String? addressID;
  final  double? totalAmount;
  final String? sellerUID;
  PlacedOrderScreen({this.addressID,this.totalAmount,this.sellerUID});

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {

  String orderId=DateTime.now().millisecondsSinceEpoch.toString();
  addOrderDetails()
  {
    orderDetailsForCustomer(
      {
        "addressID":widget.addressID,
        "totalAmount":widget.totalAmount,
        "orderBy":sharedPreferences!.getString("uid"),
        "productIDs":sharedPreferences!.getStringList("userCart"),
        "paymentDetails":"Cash on Delivery",
        "orderTime":orderId,
        "isSuccess":"isSuccess",
        "sellerUID":widget.sellerUID,
        "orderId":orderId,
        "status":"normal",

      }
    );

    orderDetailsForSeller(
      {
        "addressID":widget.addressID,
        "totalAmount":widget.totalAmount,
        "orderBy":sharedPreferences!.getString("uid"),
        "productIDs":sharedPreferences!.getStringList("userCart"),
        "paymentDetails":"Cash on Delivery",
        "orderTime":orderId,
        "isSuccess":"isSuccess",
        "sellerUID":widget.sellerUID,
        "orderId":orderId,
        "status":"normal",

      }
    ).whenComplete((){
      
      clearCart(context);
      setState(() {
        orderId="";
        Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
        Fluttertoast.showToast(msg: "Congratulations, Order has been placed successfully.");
      });
    });


  }

  Future orderDetailsForCustomer(Map<String,dynamic>data) async
  {
    await FirebaseFirestore.instance.collection("customer").doc(sharedPreferences!.getString("uid")).collection("orders").doc(orderId).set(data);
  }
  Future orderDetailsForSeller(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }



  @override
  Widget build(BuildContext context) {
    return Material(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/food_delivery.jpg"),
          SizedBox(height: 15,),

          ElevatedButton(
            child: const Text("Placed Order"),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
            ),
            onPressed: ()
            {
              addOrderDetails();
            },
          )


        ],
      ),

    );
  }
}