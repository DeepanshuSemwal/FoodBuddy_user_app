import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/widgets/custum_text_field_2.dart';
import 'package:wow_food_user_app/widgets/simple_appBar.dart';

import '../models/address.dart';

class SaveAddressScreen extends StatelessWidget {


  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _country = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;
  Position? position;


  getUserLocationAddress()async
  {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Error");
      }
    }

    Position newPosition=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position=newPosition;
    placemarks=await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
    );
    Placemark pMark=placemarks![0];
    String completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    _locationController.text=completeAddress;
    _flatNumber.text = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    _city.text = '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
    _country.text = '${pMark.country}';
    _completeAddress.text = completeAddress;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed:()
          {
            if(formKey.currentState!.validate())
              {
                final model=Address(
                  name: _name.text.trim(),
                    phoneNumber: _phoneNumber.text.trim(),
                  country: _country.text.trim(),
                  completeAddress: _completeAddress.text.trim(),
                  flatNumber: _flatNumber.text.trim(),
                  city: _city.text.trim(),
                  lat: position!.latitude,
                  lng: position!.longitude
                ).toJson();

                // saving data to firebase (customerAddress sub collection has been created)
                
                FirebaseFirestore.instance.collection("customer").doc(sharedPreferences!.getString("uid")).collection("customerAddress").doc(DateTime.now().millisecond.toString()).set(model).then((value) 
                
                    { 
                      Fluttertoast.showToast(msg: "New Address has been saved successfully.");
                      formKey.currentState!.reset();
                      
                    }
                );
                
              }

          },
          label: Text("Save Address"),
        icon: Icon(Icons.check,
        color: Colors.white,
        ),
        backgroundColor: Colors.red,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 7,),
            Align(
              child: Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  "Save  New Address: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_pin_circle_outlined,
                color: Colors.white,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black
                  ),
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: "What's your address ?",
                    hintStyle: TextStyle(
                      color: Colors.black,

                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 7,),
            ElevatedButton.icon(
                onPressed: ()
                {
                  // get location
                  getUserLocationAddress();
                },
              label: Text(
                "Get my location",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.location_on,color: Colors.white,),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.red),

                ))
              ),




            ),
            Form(
              key: formKey,
                child: Column(

                  children: [

                    CustumTextField2(
                      hint: "Name",
                      controller: _name,
                    ),
                    CustumTextField2(
                      hint: "Phone Number",
                      controller: _phoneNumber,
                    ),
                    CustumTextField2(
                      hint: "City",
                      controller: _city,
                    ),
                    CustumTextField2(
                      hint: "State/Country",
                      controller: _country,
                    ),
                    CustumTextField2(
                      hint: "Address Line",
                      controller: _flatNumber,
                    ),
                    CustumTextField2(
                      hint: "Complete Address",
                      controller: _completeAddress,
                    ),



                  ],
                ),


            )

          ],
        ),
      ),

    );
  }
}
