import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget? bottom;

  SimpleAppBar({this.bottom});

  @override
  Size get preferredSize => bottom==null?Size(56, AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
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
      centerTitle: true,
      title: const Text(
        "iFood",
        style: TextStyle(fontSize: 45.0, letterSpacing: 3, color: Colors.white, fontFamily: "Signatra"),
      ),
    );
  }
}