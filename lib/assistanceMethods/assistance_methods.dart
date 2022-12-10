import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wow_food_user_app/global/global.dart';


addItemtoCart(String? foodItemId,BuildContext context,int itemCounter)
{

  List<String>? tempList=sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId!+ ":$itemCounter");

  FirebaseFirestore.instance.collection("user").doc(firebaseAuth.currentUser!.uid).update({
    "userCart":tempList,

  }).then((value) {

    Fluttertoast.showToast(msg: "Item Added Sucessfully");
    sharedPreferences!.setStringList("userCart",tempList);
  });


}