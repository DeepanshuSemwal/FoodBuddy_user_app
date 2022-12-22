
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wow_food_user_app/models/address.dart';
import 'package:wow_food_user_app/widgets/progress_bar.dart';
import 'package:wow_food_user_app/widgets/shipment_address_design.dart';
import 'package:wow_food_user_app/widgets/status_banner.dart';

import '../global/global.dart';

class OrderDetailScreen extends StatefulWidget {

  final String?orderID;
  OrderDetailScreen({this.orderID});
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String orderStatus="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: FutureBuilder<DocumentSnapshot>(

          future: FirebaseFirestore.instance.collection("customer").doc(sharedPreferences!.getString("uid")).collection("orders")
          .doc(widget.orderID).get(),

          builder: (c,snapshot)
          {
            Map? dataMap;
            if(snapshot.hasData)
              {
                dataMap=snapshot.data!.data() as Map<String,dynamic>;
                orderStatus=dataMap["status"].toString();
              }
            return snapshot.hasData ?
                Container(
                  child: Column(
                    children: [
                      StatusBanner(
                        status: dataMap!["isSuccess"],
                        orderStatus: orderStatus,
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Amount = " +"₹ "+ dataMap["totalAmount"].toString(),
                          style: TextStyle
                            (
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "oswald",

                          ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                         "Order ID = "+ widget.orderID!,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Oswald"
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Order At"+ DateFormat("dd MMMM, yyyy-hh:mm:aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"]))),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        ),
                      ),
                      Divider(thickness: 4,),
                      orderStatus=="ended"? Image.asset("images/food_delivered.png"):Image.asset("images/food_delivery_stages.png"),
                      Divider(thickness: 4,),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance.collection("customer").doc(sharedPreferences!.getString("uid"))
                                .collection("customerAddress").doc(dataMap["addressID"]).get(),
                        builder: (c,snapshot)
                        {
                          return snapshot.hasData ? ShipmentAddressDesign(
                            model: Address.fromJson(
                              snapshot.data!.data()! as Map<String,dynamic>
                            ),
                          ):Center(child: CircularProgressBar(),);
                        }
                        ,
                      )

                    ],
                  ),
                ): Center(child: CircularProgressBar(),);
          },



      ),
      ),

    );
  }
}
