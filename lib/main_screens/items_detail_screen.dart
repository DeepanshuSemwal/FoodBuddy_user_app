import 'package:flutter/material.dart';
import 'package:wow_food_user_app/models/items.dart';
import 'package:wow_food_user_app/widgets/custum_app_bar.dart';

class ItemDetialScreen extends StatefulWidget {
   final Items? model;

  ItemDetialScreen({required this.model});

  @override
  State<ItemDetialScreen> createState() => _ItemDetialScreenState();
}

class _ItemDetialScreenState extends State<ItemDetialScreen> {
  @override
  Widget build(BuildContext context) {
    return CustumAppBar();
  }
}


