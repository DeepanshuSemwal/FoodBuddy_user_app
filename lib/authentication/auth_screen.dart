import'package:flutter/material.dart';
import 'package:wow_food_user_app/authentication/login_screen.dart';
import 'package:wow_food_user_app/authentication/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          title: Text(
            "Wow Food",

            style: TextStyle(
              fontFamily: "DancingScript",
              fontSize: 70,
              fontWeight: FontWeight.bold,



            ),
          ),
          centerTitle: true,

          bottom: TabBar(
            tabs: [
                Tab(icon: Icon(Icons.login,color: Colors.white,),
                text: "Login",
                ),

              Tab(icon: Icon(Icons.app_registration,color: Colors.white,),
                text: "Register",
              ),

            ],
            indicatorColor: Colors.white,
          ),

        ),
        body: Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: <Color>[Colors.red.shade900,Colors.red.shade400,Colors.red.shade900],
          //     ),
          // ),
          child: TabBarView(
            children: [
              LoginScreen(),
              SignUp(),

            ],
          ),

        ),


      ),


    );
  }
}
