import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shops/models/user_model.dart';
import 'package:shops/utility/my_constant.dart';

class ShowAllProductBuyer extends StatefulWidget {
  const ShowAllProductBuyer({Key? key}) : super(key: key);

  @override
  _ShowAllProductBuyerState createState() => _ShowAllProductBuyerState();
}

class _ShowAllProductBuyerState extends State<ShowAllProductBuyer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readApiAllShop();
  }

  Future<Null> readApiAllShop() async {
    String urlAPI = '${MyConstant.domain}/shops/getUserWhereSeller.php';
    await Dio().get(urlAPI).then((value) {
      var result = json.decode(value.data);
      for (var item in result) {
        UserModel model = UserModel.fromMap(item);
        print('name ==>> ${model.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Show All Product'),
    );
  }
}
