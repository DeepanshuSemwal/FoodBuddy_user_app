import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_food_user_app/main_screens/cart_screen.dart';

import '../assistanceMethods/cart_item_counter.dart';

class CustumAppBar extends StatefulWidget with PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  CustumAppBar({this.bottom,this.sellerUID});

  @override
  _CustumAppBarState createState() => _CustumAppBarState();

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}

class _CustumAppBarState extends State<CustumAppBar>
{
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        icon: const Icon(Icons.arrow_back),
        onPressed: ()
        {
          Navigator.pop(context);
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
                    color: Colors.white,
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
    );
  }
}
