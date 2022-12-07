import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wow_food_user_app/authentication/auth_screen.dart';
import 'package:wow_food_user_app/main_screens/home_screen.dart';
import '../global/global.dart';


import '../authentication/login_screen.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({Key? key}) : super(key: key);

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  void setTimer() {
    Timer(const Duration(seconds: 2), () async {
      // if user is already logged in
      if(firebaseAuth.currentUser!=null)
        {
          Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));
        }
     else
       {
         Navigator.push(context,
             MaterialPageRoute(builder: (context) => const AuthScreen()));
       }
    });
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.red.shade900,Colors.red.shade400,Colors.red.shade900],
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/slash_image.jpg"),

            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                "Buy Food Online ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight:FontWeight.bold ,
                  fontFamily: "DancingScript",

                  letterSpacing: 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}