import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:wow_food_user_app/models/items.dart';
import 'package:wow_food_user_app/widgets/custum_app_bar.dart';

import '../assistanceMethods/assistance_methods.dart';

class ItemDetialScreen extends StatefulWidget {
   final Items? model;

  ItemDetialScreen({required this.model});

  @override
  State<ItemDetialScreen> createState() => _ItemDetialScreenState();
}

class _ItemDetialScreenState extends State<ItemDetialScreen> {

  TextEditingController counterController=TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustumAppBar(sellerUID: widget.model!.sellersId,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
           child:Image.network(widget.model!.thumbnail.toString(),
             fit: BoxFit.fill,

           ),
           height: 250,
           width: MediaQuery.of(context).size.width,

         ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: NumberInputPrefabbed.roundedButtons(

              controller: counterController,
              incDecBgColor: Colors.red,
              min: 1,
              max: 100,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incRightDecLeft,

            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.model!.itemTitle.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.model!.itemDescription.toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              " ₹ "+widget.model!.price.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 25,),

          // I can also use elevated button but iam implementing inkwell as a button

          InkWell(

            onTap: ()
            {
              int itemCounter=int.parse(counterController.text);
              List<String> seperateItemIDsList= separateItemIDs();
              // 1 check item already exist
              // 2 calling add item function
              seperateItemIDsList.contains(widget.model!.itemId)?Fluttertoast.showToast(msg: "Item already present to cart"):
              addItemtoCart(widget.model!.itemId,context,itemCounter);
            },

            child: Padding(

              padding: EdgeInsets.only(left: 20,right: 20),

              child: Container(


                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.red.shade800,Colors.green.shade700],
                      begin:FractionalOffset(0.0,0.0,),
                      end:FractionalOffset(1.0,0.0),
                      stops: [1.0,0.0],
                      tileMode: TileMode.clamp

                  ),

                ),
                height: 50,
                width: MediaQuery.of(context).size.width,

                child: Center(
                  child: Text
                    ("Add to cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),

                  ),

                ),
              ),
            ),

          ),


        ],
      ),

    );
  }
}


