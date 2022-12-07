import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Colors.red,
        ),
      ),
    );
  }
}