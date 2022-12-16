import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow_food_user_app/assistanceMethods/cart_item_counter.dart';
import 'package:wow_food_user_app/assistanceMethods/total_amount.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/slash_screen/slash_screen.dart';

import 'assistanceMethods/address_changer.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (c)=>CartItemCounter()),
      ChangeNotifierProvider(create: (c)=>TotalAmount()),
      ChangeNotifierProvider(create: (c)=>AddressChanger()),
    ],

    child:  MaterialApp(
      title: "customer App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SlashScreen(),
    ),

    );
  }
}
