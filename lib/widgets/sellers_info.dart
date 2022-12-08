import 'package:flutter/material.dart';
import 'package:wow_food_user_app/main_screens/menu_screen.dart';

import '../models/sellers.dart';

class SellersInfoDesign extends StatefulWidget {

  Sellers? model;
  BuildContext? context;
  SellersInfoDesign({required this.model,required this.context});

  @override
  State<SellersInfoDesign> createState() => _SellersInfoDesignState();
}

class _SellersInfoDesignState extends State<SellersInfoDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MenusScreen(model: widget.model,)));
      },

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

                widget.model!.sellerAvatar!,
                height:220,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 2,),
              Text(
                widget.model!.sellerName!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Oswald-Bold",
                ),
              ),

              Text(
                widget.model!.sellerEmail!,
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

