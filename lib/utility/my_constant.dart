import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'CHANYONT';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSalerService = '/salerService';
  static String routeRiderService = '/riderService';

  // Image
  static String image0 = 'images/chanyontlogo.png';
  static String image1 = 'images/shops1.png';
  static String image2 = 'images/shops2.png';
  static String image3 = 'images/shops3.png';
  static String image4 = 'images/shops4.png';
  static String image5 = 'images/shops5.png';

  // Color
  static Color primary = Color(0xffdd0000);
  static Color dark = Color(0xffa20000);
  static Color light = Color(0xffff5332);

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
