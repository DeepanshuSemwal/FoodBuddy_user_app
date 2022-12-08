import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:wow_food_user_app/models/items.dart';
import 'package:wow_food_user_app/widgets/custum_app_bar.dart';

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
      appBar: CustumAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
           child:Image.network(widget.model!.thumbnail.toString(),
             fit: BoxFit.fill,

           ),
           height: 300,
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
        ],
      ),

    );
  }
}


