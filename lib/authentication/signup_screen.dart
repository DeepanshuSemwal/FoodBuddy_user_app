import 'dart:ffi';
import 'dart:io';
import 'dart:math';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow_food_user_app/main_screens/home_screen.dart';
import 'package:wow_food_user_app/widgets/custom_text_field.dart';
import 'package:toast/toast.dart';
import 'package:firebase_storage/firebase_storage.dart ' as fStorage;

import '../global/global.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/loading_bar.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  XFile?imageXFile;
  final ImagePicker _imagePicker=ImagePicker();
   Position? position;
   String completeAddress="";
   List<Placemark>? placemark;
   String customerImageUrl="";

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController locationController=TextEditingController();

  Future<void>getImage() async
  {
      imageXFile=await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(()
      {
          imageXFile;
      }
      );
  }

  Future<void>formValidation() async
  {
    if(imageXFile==null)
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(message: "Please select an image for profile.");
            }
        );
      }
    else
            {
            if(passwordController.text==confirmPasswordController.text)
            {
            if(passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty && nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty && phoneController.text.isNotEmpty && locationController.text.isNotEmpty)
              {
                //upload images
                showDialog(
                    context: context,
                    builder: (c)
                  {
                    return LoadingDialog(
                      message: "Registering Account",
                    );
                  },


                );
                String fileName=DateTime.now().microsecondsSinceEpoch.toString();
                //child("customer") : it create a customer folder
                fStorage.Reference reference=fStorage.FirebaseStorage.instance.ref().child("customer").child(fileName);
                fStorage.UploadTask uploadTask=reference.putFile(File(imageXFile!.path));
                // url : link for accessing images
                fStorage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() {});
                await taskSnapshot.ref.getDownloadURL().then((url) => {

                  customerImageUrl=url,

                  //save info to firestore
                  authenticateSellerAndSignup(),


                });


              }
            else
              {
                showDialog(
                    context: context,
                    builder: (c)
                    {
                      return ErrorDialog(message: "Please fill the required information for the registration");
                    }
                );

              }

          }
        else
          {
            showDialog(
                context: context,
                builder: (c)
                {
                  return ErrorDialog(message: "Password do not match");
                }
            );
          }

      }
  }


  Future saveDataToFirestore(User currentUser) async
  {
    FirebaseFirestore.instance.collection("customer").doc(currentUser.uid).set(

      {
          "customerUID": currentUser.uid,
          "customerEmail": currentUser.email,
          "customerName": nameController.text.trim(),
          "customerAvatar": customerImageUrl,
          "phone" : phoneController.text,
          "adress":completeAddress,
          "status": "approved",
          "lat": position!.latitude,
          "lon": position!.longitude,
          "usercart":["garbage value"],

      }
    );
  }

  void authenticateSellerAndSignup() async
  {
    User? currentUser;
    await  firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),

    ).then((auth) {
      currentUser=auth.user;
    });
    if(currentUser!=null)
      {
        saveDataToFirestore(currentUser!).then((value) {
          Navigator.pop(context);
          //send user to home screen
          Route newRoute=MaterialPageRoute(builder: (c)=>
            HomeScreen(),
          );
          Navigator.pushReplacement(context, newRoute);
        }).catchError((Error)
        {
          Navigator.pop(context);
          showDialog(context: context, builder: (c){
            return ErrorDialog(message: Error);
          });
        });

        // save data locally using sharedPreference
         sharedPreferences=await SharedPreferences.getInstance();
        await sharedPreferences!.setString("uid", currentUser!.uid);
        await sharedPreferences!.setString("name", nameController.text.trim());
        await sharedPreferences!.setString("email", currentUser!.email.toString());
        await sharedPreferences!.setString("phone", phoneController.text.trim());
        await sharedPreferences!.setString("image", customerImageUrl);
        await sharedPreferences!.setString("Address",locationController.text.trim());
        await sharedPreferences!.setStringList("userCart", ["garbage value"]);


      }
  }

  Future<void>getCurrentLocation()async
  {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          throw Exception("Error");
        }
      }
      // else
      //   {
      //     throw Exception("Error");
      //   }

    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placemark = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    // since google map returns a lot of address in list so we take 0th index address
    Placemark pMark = placemark![0];
    completeAddress =
    "${pMark.subThoroughfare} ${pMark.thoroughfare},${pMark
        .subLocality} ${pMark.locality} ${pMark
        .subAdministrativeArea} ${pMark.postalCode}"
        "${pMark.country}";
    locationController.text = completeAddress;


    }




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            InkWell(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.16,
                backgroundColor: Colors.redAccent,
                backgroundImage: imageXFile==null?null:FileImage(File(imageXFile!.path)),
                child: imageXFile==null
                    ?
                    Icon(
                      Icons.person,
                      size: MediaQuery.of(context).size.width*0.20,
                      color: Colors.white,
                    ):null

              ),
              onTap: getImage,
            ),
            SizedBox(height: 20,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(textEditingController: nameController, iconData: Icons.person, hintText: "Name", enable: true, isObsecre: false),
                  SizedBox(height: 10,),
                  CustomTextField(textEditingController: emailController, iconData: Icons.email, hintText:"Email" , enable: true, isObsecre:false),
                  SizedBox(height: 10,),
                  CustomTextField(textEditingController: passwordController, iconData: Icons.password, hintText: "Password", enable: true, isObsecre: true),
                  SizedBox(height: 10,),
                  CustomTextField(textEditingController: confirmPasswordController, iconData: Icons.password, hintText: "Confirm Password", enable: true, isObsecre:true),
                  SizedBox(height: 10,),
                  CustomTextField(textEditingController: phoneController, iconData: Icons.phone, hintText: "Phone", enable: true, isObsecre: false),
                  SizedBox(height: 10,),
                  CustomTextField(textEditingController: locationController, iconData: Icons.my_location, hintText: "Cafe/Restaurant Address", enable:false, isObsecre: false),
                  SizedBox(height: 15,),
                  Container(
                    width: 400,
                    height: 45,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon
                      (
                      onPressed: ()
                      {
                        getCurrentLocation();

                      }
                      ,
                      label:Text(
                        "Get my location"
                      ),
                      icon: Icon(
                        Icons.location_on,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder
                          (
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                    ),




                  ),
                  SizedBox(height: 20,),

                  ElevatedButton(


                      onPressed: ()=>formValidation(),
                      child: Text(
                    "Register",
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
                      )


                    ),

                  ),

                ],

              ),
            ),


          ],


        ),
      ),
    );
  }
}
