import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget{
  final String text;

  AppBarText({super.key,required this.text});
  @override
  Widget build(BuildContext context) {
   return  Text(
    text,
    style:TextStyle(
    color:Colors.grey,
    fontSize: 20.0

    ),
    );
  }

}