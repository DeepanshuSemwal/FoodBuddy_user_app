import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_food_user_app/assistanceMethods/assistance_methods.dart';
import 'package:wow_food_user_app/assistanceMethods/total_amount.dart';
import 'package:wow_food_user_app/widgets/cart_item_design.dart';
import 'package:wow_food_user_app/widgets/custum_app_bar.dart';
import 'package:wow_food_user_app/widgets/progress_bar.dart';
import 'package:wow_food_user_app/widgets/text_widget_header.dart';

import '../assistanceMethods/cart_item_counter.dart';
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
    totalAmount=0;
    Provider.of<TotalAmount>(context,listen: false).displayTotalAmount(0);
    separateItemQuantityList=seperateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       flexibleSpace: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
               colors: <Color>[Colors.red.shade800,Colors.green.shade700],
               begin:FractionalOffset(0.0,0.0,),
               end:FractionalOffset(1.0,0.0),
               stops: [1.0,0.0],
               tileMode: TileMode.clamp

           ),


         ),
       ),
       leading: IconButton(
         icon: const Icon(Icons.clear_all_outlined),
         onPressed: ()
         {
           clearCart(context);
         },
       ),
       title: const Text(
         "Wow Food",
         style: TextStyle(fontSize: 45, fontFamily: "DancingScript"),
       ),
       centerTitle: true,
       automaticallyImplyLeading: true,
       actions: [
         Stack(
           children: [
             IconButton(
               icon: const Icon(Icons.shopping_cart, color: Colors.white,),
               onPressed: ()
               {
                 //send user to cart screen
                 Navigator.push(context, MaterialPageRoute(builder: (c)=>CartScreen(sellerUID: widget.sellerUID,)));

               },
             ),
             Positioned(
               child: Stack(
                 children:  [
                   Icon(
                     Icons.brightness_1,
                     size: 20.0,
                     color: Colors.redAccent,
                   ),
                   Positioned(
                     top: 3,
                     right: 4,
                     child: Center(

                       child: Consumer<CartItemCounter>(
                         builder: (context, counter, c)
                         {
                           return Text(
                             counter.count.toString(),
                             style: const TextStyle(color: Colors.white, fontSize: 12),
                           );
                         },
                       ),

                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ],
     ),
      floatingActionButton: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
                onPressed: ()
                {
                    clearCart(context);
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
              delegate: TextWidgetHeader(title:"Cart List"),

          ),


          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: cartProvider.count == 0
                      ? Container() // if no item is selected in cart then return empty container
                      : Text(
                    "Total Price: " + amountProvider.tAmount.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight:  FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ),

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

                if(index==0)
                  {
                    totalAmount=0;
                    totalAmount=totalAmount+(model.price!*separateItemQuantityList![index]);
                  }
                else
                  {
                    totalAmount=totalAmount+(model.price!*separateItemQuantityList![index]);
                  }
                // come to garbage value
                if(snapshot.data!.docs.length-1==index)
                  {
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      
                      Provider.of<TotalAmount>(context,listen: false).displayTotalAmount(totalAmount.toDouble());
                    });
                  }

                return CartItemDesign(
                  model: model,
                    context: context,
                  quanNumber: separateItemQuantityList![index],
                );
              },
                childCount: snapshot.hasData ? snapshot.data!.docs.length :0 ,

              ));



            },
          )
        ],

      ),
    );
  }
}
