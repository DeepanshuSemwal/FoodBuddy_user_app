import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wow_food_user_app/authentication/auth_screen.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/main_screens/home_screen.dart';
import 'package:wow_food_user_app/widgets/alert_dialog.dart';
import 'package:wow_food_user_app/widgets/custom_text_field.dart';
import 'package:wow_food_user_app/widgets/loading_bar.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState>_formKey=GlobalKey();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      logInNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please Enter complete information",
            );
          });
    }
  }

  logInNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return  LoadingDialog(
            message: "Login",
          );
        });
    User? currentuser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentuser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentuser != null) {
      //login the user
      readDataAndSetDataLocally(currentuser!).then((value) {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (c) =>  HomeScreen()));
      });
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
   // save data locally
    await FirebaseFirestore.instance
        .collection("customer")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if(snapshot.exists)
        {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!
              .setString("email", snapshot.data()!["customerEmail"]);
          await sharedPreferences!
              .setString("name", snapshot.data()!["customerName"]);
          await sharedPreferences!
              .setString("photourl", snapshot.data()!["customerAvatar"]);
          await sharedPreferences!
              .setString("phone", snapshot.data()!["phone"]);

          List<String> userCartList=snapshot.data()!["userCart"].cast<String>();
          await sharedPreferences!
              .setStringList("userCart", userCartList);

          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
        }
      else
        {
            firebaseAuth.signOut();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));

            showDialog(
                context: context,
                builder: (c) {
                  return ErrorDialog(
                    message: "No record Exists",
                  );
                });
        }
    });
  }

  @override
  Widget build(BuildContext context) {

      return SingleChildScrollView(
        child: Column(

          children: [
            Container
              (
              alignment: Alignment.center,

              child: Padding(
                    padding: EdgeInsets.all(15),
                  child: Image.asset("images/login_image.jpg")),
                   height: 250,
            ),
            SizedBox(height: 10,),

            Column(
              children: [
                Text(
                  "Welcome customer!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: "Oswald",
                    fontSize: 25,


                  ),
                ),
                Text(
                  "Buy Food Online",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: "Oswald",
                    fontSize: 20,
                  ),
                ),

              ],
            ),

            SizedBox(height: 30,),
            Form
              (
              key: _formKey,
                child:Column(
                  mainAxisSize: MainAxisSize.max,

                children: [

                  CustomTextField(textEditingController: emailController, iconData: Icons.email, hintText: "Email", enable: true, isObsecre: false),
                  SizedBox(height: 10,),
                  CustomTextField(textEditingController: passwordController, iconData: Icons.password, hintText: "Password", enable: true, isObsecre: true),
        ],

            ),
            ),
             SizedBox(height: 35,),

            ElevatedButton(


              onPressed: ()
              {
                  formValidation();
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),

              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade500,
                  padding: EdgeInsets.symmetric(horizontal: 150,vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
            ),
          ],
        ),

    );
  }
}