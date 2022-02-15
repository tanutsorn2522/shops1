import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'CHANYONT';
  static String domain = 'https://4d3f-49-49-73-66.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSellerService = '/sellerService';
  static String routeRiderService = '/riderService';
  static String routeAddProduce = '/addProduct';

  // Image
  static String image0 = 'images/chanyontlogo.png';
  static String image1 = 'images/shops1.png';
  static String image2 = 'images/shops2.png';
  static String image3 = 'images/shops3.png';
  static String image4 = 'images/shops4.png';
  static String image5 = 'images/shops5.png';
  static String avatar = 'images/avatar.png';
  static String camera = 'images/camera.png';
  static String camera1 = 'images/camera1.png';
  static String camera2 = 'images/camera2.png';
  static String folderimage = 'images/folder_image.png';
  static String imageicon = 'images/image_icon.png';
  static String imageicon1 = 'images/image_icon1.png';
  static String imageicon2 = 'images/image_icon2.png';

  // Color
  static Color primary = Color(0xffdd0000);
  static Color dark = Color(0xffa20000);
  static Color light = Color(0xffff5332);
  Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(221, 0, 0, 0.1),
    100: Color.fromRGBO(221, 0, 0, 0.2),
    200: Color.fromRGBO(221, 0, 0, 0.3),
    300: Color.fromRGBO(221, 0, 0, 0.4),
    400: Color.fromRGBO(221, 0, 0, 0.5),
    500: Color.fromRGBO(221, 0, 0, 0.6),
    600: Color.fromRGBO(221, 0, 0, 0.7),
    700: Color.fromRGBO(221, 0, 0, 0.8),
    800: Color.fromRGBO(221, 0, 0, 0.9),
    900: Color.fromRGBO(221, 0, 0, 1.0),
  };

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

  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  TextStyle h4Style() => TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
