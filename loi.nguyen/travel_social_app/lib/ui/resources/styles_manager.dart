import 'package:flutter/material.dart';

TextStyle getLabelText({Color color = Colors.black}) =>
    TextStyle(color: color, fontSize: 14,  fontFamily: 'Ubuntu-Regular',);

TextStyle getTitle1Text(
        {Color color = Colors.black, fontWeight = FontWeight.bold}) =>
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: color,  fontFamily: 'Ubuntu-Regular',);

TextStyle getTitle2Text({Color color = Colors.black}) =>
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: color,  fontFamily: 'Ubuntu-Regular',);
