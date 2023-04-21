import 'package:flutter/material.dart';

TextStyle getLabelText({Color color = Colors.black}) =>
    TextStyle(color: color, fontSize: 14);

TextStyle getTitleText({Color color = Colors.black, FontWeight fontWeight= FontWeight.normal}) =>
    TextStyle(color: color, fontSize: 18, fontWeight: fontWeight);
