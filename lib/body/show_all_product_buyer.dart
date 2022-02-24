import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shops/models/user_model.dart';
import 'package:shops/states/Show_product_buyer.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_image.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_title.dart';

class ShowAllProductBuyer extends StatefulWidget {
  const ShowAllProductBuyer({Key? key}) : super(key: key);

  @override
  _ShowAllProductBuyerState createState() => _ShowAllProductBuyerState();
}

class _ShowAllProductBuyerState extends State<ShowAllProductBuyer> {
  bool load = true;
  List<UserModel> userModels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readApiAllShop();
  }

  Future<Null> readApiAllShop() async {
    String urlAPI = '${MyConstant.domain}/shops/getUserWhereSeller.php';
    await Dio().get(urlAPI).then((value) {
      setState(() {
        load = false;
      });
      var result = json.decode(value.data);
      for (var item in result) {
        UserModel model = UserModel.fromMap(item);
        //print('name ==>> ${model.name}');
        setState(() {
          userModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : GridView.builder(
              itemCount: userModels.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 2 / 2, maxCrossAxisExtent: 160),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  //print('You Click from ${userModels[index].name}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowProductBuyer(userModel: userModels[index]),
                      ));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  ShowImage(path: MyConstant.avatar),
                              placeholder: (context, url) => ShowProgress(),
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${MyConstant.domain}/shops/img/avatar/${userModels[index].avatar}'),
                        ),
                        ShowTitle(
                            title: cutWord(userModels[index].name),
                            textStyle: MyConstant().h3Style()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  String cutWord(String name) {
    String result = name;
    if (result.length > 19) {
      result = result.substring(0, 15);
      result = '$result ...';
    }
    return result;
  }
}
