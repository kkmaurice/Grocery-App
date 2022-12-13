import 'package:flutter/material.dart';

class GlobalMethods {
 static navigateTo({ required context, required String routeName}){
    Navigator.pushNamed(context, routeName);
  }
}