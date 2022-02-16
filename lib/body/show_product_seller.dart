import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/models/product_model.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_progress.dart';

class ShowProductSeller extends StatefulWidget {
  ShowProductSeller({Key? key}) : super(key: key);

  @override
  State<ShowProductSeller> createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  bool load = true;

  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;

    String apiGetProductWhereIdSeller =
        '${MyConstant.domain}/shops/getProductWhereSeller.php?isAdd=true&idSeller=$id';
    await Dio().get(apiGetProductWhereIdSeller).then((value) {
      for (var item in json.decode(value.data)) {
        ProductModel model = ProductModel.fromMap(item);
        print('name Product ==>> ${model.name}');

        setState(() {
          load = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load ? ShowProgress() : Text('Load Finish'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.primary,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduce),
        child: Text('Add'),
      ),
    );
  }
}
