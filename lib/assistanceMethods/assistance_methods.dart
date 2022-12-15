import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wow_food_user_app/assistanceMethods/cart_item_counter.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/slash_screen/slash_screen.dart';



separateItemIDs()
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

    //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\nThis is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}





addItemtoCart(String? foodItemId,BuildContext context,int itemCounter)
{

  List<String>? tempList=sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId!+ ":$itemCounter");

  FirebaseFirestore.instance.collection("customer").doc(firebaseAuth.currentUser!.uid).update({
    "usercart":tempList,

  }).then((value) {

    Fluttertoast.showToast(msg: "Item Added Sucessfully");
    sharedPreferences!.setStringList("userCart",tempList);

    // update batch
    Provider.of<CartItemCounter>(context,listen: false).displayCartListItemsNumber();

  });


}

seperateItemQuantities()
{

  List<int> separateQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    //0:
    //1=7
    //:7
   List<String>listItemCharacters=item.split(":").toList();

   //7



   var quanNumber=int.parse(listItemCharacters[1].toString());

    //56557657


    print("\nThis is Quantity now = " + quanNumber.toString());

    separateQuantityList.add(quanNumber);
  }


  return separateQuantityList;


}
clearCart(context)
{
  sharedPreferences!.setStringList("userCart", ["garbage value"]);
  List<String>?emptyList= sharedPreferences!.getStringList("userCart");
  FirebaseFirestore.instance.collection("customer").doc(firebaseAuth.currentUser!.uid).update({"userCart":emptyList!}).then((value)
  {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context,listen: false).displayCartListItemsNumber();

  }
  );


}


