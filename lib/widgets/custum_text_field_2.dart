import 'package:flutter/material.dart';

class CustumTextField2 extends StatelessWidget
{
  final String? hint;
  final TextEditingController? controller;

  CustumTextField2({this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (value) => value!.isEmpty ? "Field can not be empty" : null,
      ),
    );
  }
}