import 'package:flutter/material.dart';


class ScreenSize{
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  void init(BoxConstraints constraints, Orientation orientation){
    screenWidth = constraints.maxWidth;
    screenHeight = constraints.maxHeight;
  }

}