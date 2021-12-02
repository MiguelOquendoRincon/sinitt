import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinitt/utils/hexcolor.dart';

class TextStyles {
  TextStyle whiteText({
    Color color = Colors.white, 
    BuildContext? context,
    double? fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal
  }) {
    if (context != null) {
      return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      );
    }
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  TextStyle blueText({
    Color color = Colors.blue, 
    BuildContext? context,
    double? fontSize = 15.0,
    FontWeight fontWeight = FontWeight.normal
  }) {
    if (context != null) {
      color = Theme.of(context).primaryColor;
      return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      );
    }
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  TextStyle blackText({
    Color color = Colors.black, 
    BuildContext? context,
    double? fontSize = 15.0,
    FontWeight fontWeight = FontWeight.normal
  }) {
    if (context != null) {
      return TextStyle(
        color: HexColor('#4B4B4B'),
        fontSize: fontSize,
        fontWeight: fontWeight
      );
    }
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  TextStyle greyText({
    Color color = Colors.grey, 
    BuildContext? context,
    double? fontSize = 14.0,
    FontWeight fontWeight = FontWeight.normal,
    bool lightGrey = false
  }) {
    if (context != null) {
      if(lightGrey){
        return TextStyle(
          color: HexColor('#BABABA'),
          fontSize: fontSize,
          fontWeight: fontWeight
        );
      } else{
        return TextStyle(
          color: HexColor('#4C4B4B'),
          fontSize: fontSize,
          fontWeight: fontWeight
        );
      }
      
    }
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  // TextStyle buttonCardLargeText(
  //     {Color color = Colors.white, BuildContext? context}) {
  //   if (context != null) {
  //     return TextStyle(
  //         color: color,
  //         fontSize: (DeviceSize.getDeviceSize(context)['height']! * .05)
  //             .roundToDouble());
  //   }
  //   return TextStyle(color: color, fontSize: 35, fontWeight: FontWeight.normal);
  // }

  // TextStyle buttonCardSmallText(
  //     {Color color = Colors.white, BuildContext? context}) {
  //   if (context != null) {
  //     return TextStyle(
  //         color: color,
  //         fontSize: (DeviceSize.getDeviceSize(context)['height']! * .03)
  //             .roundToDouble());
  //   }
  //   return TextStyle(color: color, fontSize: 20);
  // }

  // TextStyle alphaMediumText({BuildContext? context}) {
  //   if (context != null) {
  //     return TextStyle(
  //         color: Color.fromARGB(50, 255, 255, 255),
  //         fontSize: (DeviceSize.getDeviceSize(context)['height']! * .03)
  //             .roundToDouble());
  //   }
  //   return const TextStyle(
  //       color: Color.fromARGB(50, 255, 255, 255), fontSize: 30);
  // }

  // TextStyle smallText({Color color = Colors.white, BuildContext? context}) {
  //   if (context != null) {
  //     return TextStyle(
  //         color: color,
  //         fontSize: (DeviceSize.getDeviceSize(context)['height']! * .03)
  //             .roundToDouble());
  //   }
  //   return TextStyle(color: color, fontSize: 20);
  // }
}
