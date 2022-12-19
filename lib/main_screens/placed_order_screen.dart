
import 'package:flutter/material.dart';
class PlacedOrderScreen extends StatefulWidget {

  final String? addressID;
  final  double? totalAmount;
  final String? sellerUID;
  PlacedOrderScreen({this.addressID,this.totalAmount,this.sellerUID});

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
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
            },
          )


        ],
      ),

    );
  }
}