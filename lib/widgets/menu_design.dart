import 'package:flutter/material.dart';
import 'package:wow_food_user_app/main_screens/item_screen.dart';

import '../models/menus.dart';
import '../models/sellers.dart';

class MenuDesign extends StatefulWidget {

  Menus? model;
  BuildContext? context;
  MenuDesign({required this.model,required this.context});

  @override
  State<MenuDesign> createState() => _MenuDesignState();
}

class _MenuDesignState extends State<MenuDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model: widget.model,)));
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

                widget.model!.thumbnail!,
                height:220,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 1,),
              Text(
                widget.model!.menuTitle!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Oswald-Bold",
                ),
              ),

              Text(
                widget.model!.menuInfo!,
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

