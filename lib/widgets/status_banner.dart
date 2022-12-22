import 'package:flutter/material.dart';
import 'package:wow_food_user_app/main_screens/home_screen.dart';

class StatusBanner extends StatelessWidget {
  final bool? status;
  final String? orderStatus;
  StatusBanner({this.status,this.orderStatus});

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;
    status! ? iconData=Icons.done : iconData=Icons.cancel;
    status! ? message="Successfull":message="Unsuccessful";
    return Container(

      height:40 ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20,),
          Text(
            orderStatus=="eneded" ? "Order Delivered $message"
                : "Order Placed $message",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5,),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
        
  }
}
