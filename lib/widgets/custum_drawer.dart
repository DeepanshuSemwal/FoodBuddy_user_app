import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/main_screens/address_screen.dart';
import 'package:wow_food_user_app/main_screens/history_screen.dart';
import 'package:wow_food_user_app/main_screens/my_order_screen.dart';

import '../authentication/auth_screen.dart';


class CustumDrawer extends StatelessWidget {
  const CustumDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top:25,bottom: 10),

            child:Column(
              children: [
                // header drawer
                Material(

                  borderRadius: BorderRadius.all(Radius.circular(80),),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photourl")!,

                        ),
                      ),


                    ),

                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Oswald",
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12,),

                Container(

                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey,
                          height: 10,
                        thickness: 2,
                      ),
                      ListTile(
                        leading: Icon(Icons.home,color: Colors.black,),
                        title: Text(
                          "Home",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: ()
                        {

                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.reorder,color: Colors.black,),
                        title: Text(
                          "My order",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>MyOrderScreen()));

                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.history,color: Colors.black,),
                        title: Text(
                          "History",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>HistoryScreen()));

                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.search,color: Colors.black,),
                        title: Text(
                          "Search",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: ()
                        {

                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.add_location,color: Colors.black,),
                        title: Text(
                          "Add New Address",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: ()
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=>AddressScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout,color: Colors.black,),
                        title: Text(
                          "Sign Out",
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: ()
                        {
                          firebaseAuth.signOut().then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
                          });
                        },
                      ),
                    ],
                  ),
                ),







              ],
            ) ,
          ),

        ],
      ),
    );
  }
}
