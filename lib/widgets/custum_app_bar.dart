import 'package:flutter/material.dart';

class CustumAppBar extends StatefulWidget with PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;
  CustumAppBar({this.bottom});

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
        "iFood",
        style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
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
              },
            ),
            Positioned(
              child: Stack(
                children: const [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 3,
                    right: 4,
                    child: Center(
                      child: Text("0", style: TextStyle(color: Colors.black, fontSize: 12),),
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
