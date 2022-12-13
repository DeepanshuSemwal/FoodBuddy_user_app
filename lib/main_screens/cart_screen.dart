import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wow_food_user_app/assistanceMethods/assistance_methods.dart';
import 'package:wow_food_user_app/widgets/cart_item_design.dart';
import 'package:wow_food_user_app/widgets/custum_app_bar.dart';
import 'package:wow_food_user_app/widgets/progress_bar.dart';
import 'package:wow_food_user_app/widgets/text_widget_header.dart';

import '../models/items.dart';

class CartScreen extends StatefulWidget {

  final String? sellerUID;
  CartScreen({this.sellerUID});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<int>? separateItemQuantityList;
  num totalAmount = 0;

  @override
  void initState()
  {
    super.initState();
    seperateItemQuantities();
  }

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
      body: CustomScrollView(
        slivers: [

          // overall total amount
          SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(title: "Total amount = 150")),
          // display cart items with quantity numbers
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("items").where("itemId",whereIn: separateItemIDs()).orderBy("published",descending: true).snapshots(),
            builder: (context,snapshot)
            {
              return !snapshot.hasData?SliverToBoxAdapter(
                child: Center(
                    child: CircularProgressBar(),
                ),
              ):snapshot.data!.docs.length==0
                  ? Container()
                  : SliverList(delegate: SliverChildBuilderDelegate((context, index) {

                Items model = Items.fromJson(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                );
                return CartItemDesign(
                  model: model,
                    context: context,
                  quanNumber: separateItemQuantityList![index],
                );
              }));



            },
          )
        ],

      ),
    );
  }
}
