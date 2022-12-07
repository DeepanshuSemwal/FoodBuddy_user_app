import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {


   final TextEditingController textEditingController;
   final IconData iconData;
   final String hintText;
    bool isObsecre=true;
    bool enable=true;


   CustomTextField(
       {required this.textEditingController,
         required this.iconData,
         required this.hintText,
         required this.enable,
         required this.isObsecre,
   }
   );


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: textEditingController,
      obscureText: isObsecre,
      style: TextStyle(
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(

        prefixIcon: Icon(
          iconData,
          color: Colors.black87,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.black87,
        ),

        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),


      ),


    );
  }
}
