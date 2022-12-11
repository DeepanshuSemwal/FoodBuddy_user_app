import 'package:flutter/material.dart';
import 'package:wow_food_user_app/widgets/custum_app_bar.dart';

class CartScreen extends StatefulWidget {

  final String? sellerUID;
  CartScreen({this.sellerUID});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustumAppBar(sellerUID: widget.sellerUID),
      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
                onPressed: ()
                {

                },
                label: Text("Clear Cart",

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              backgroundColor: Colors.red,
              icon: Icon(Icons.clear_all_outlined),


            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              onPressed: ()
              {

              },
              label: Text("Check Out",

                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.red,
              icon: Icon(Icons.navigate_next),


            ),
          ),




        ],


      ),
    );
  }
}
