import 'package:flutter/material.dart';

import '../models/items.dart';
import '../models/menus.dart';
import '../models/sellers.dart';

class ItemDesign extends StatefulWidget {

  Items? model;
  BuildContext? context;
  ItemDesign({required this.model,required this.context});

  @override
  State<ItemDesign> createState() => _ItemDesignState();
}

class _ItemDesignState extends State<ItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

      splashColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(

                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(

                widget.model!.thumbnail!,
                height:220,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 2,),
              Text(
                widget.model!.itemTitle!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Oswald-Bold",
                ),
              ),

              Text(
                widget.model!.itemDescription!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "Oswald-Bold",
                ),
              ),

              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),


            ],
          ),
        ),
      ),
    );
  }
}

