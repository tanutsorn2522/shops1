import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shops/models/product_model.dart';
import 'package:shops/models/sqlite_model.dart';
import 'package:shops/models/user_model.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/utility/my_dialog.dart';
import 'package:shops/utility/sqlite_helper.dart';
import 'package:shops/widgets/show_image.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_title.dart';

class ShowProductBuyer extends StatefulWidget {
  final UserModel userModel;
  const ShowProductBuyer({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShowProductBuyerState createState() => _ShowProductBuyerState();
}

class _ShowProductBuyerState extends State<ShowProductBuyer> {
  UserModel? userModel;
  bool load = true;
  bool? haveProduct;
  List<ProductModel> productModels = [];
  List<List<String>> listImages = [];
  int indexImage = 0;
  int amountInt = 1;
  String? currentIdSeller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
    readAPI();
    readCard();
  }

  Future<Null> readCard() async {
    await SQLiteHelper().readSQLite().then((value) {
      if (value.length != 0) {
        List<SQLiteModel> models = [];
        for (var model in value) {
          models.add(model);
        }
        currentIdSeller = models[0].idSeller;
        //print('### currentIdSeller ==>> $currentIdSeller');
      }
    });
  }

  Future<void> readAPI() async {
    String urlAPI =
        '${MyConstant.domain}/shops/getProductWhereSeller.php?isAdd=true&idSeller=${userModel!.id}';
    await Dio().get(urlAPI).then(
      (value) {
        //print('## value = $value');

        if (value.toString() == 'null') {
          setState(() {
            haveProduct = false;
            load = false;
          });
        } else {
          for (var item in json.decode(value.data)) {
            ProductModel model = ProductModel.fromMap(item);

            String string = model.images;
            string = string.substring(1, string.length - 1);
            List<String> strings = string.split(',');
            int i = 0;
            for (var item in strings) {
              strings[i] = item.trim();
              i++;
            }
            listImages.add(strings);
            setState(() {
              haveProduct = true;
              load = false;
              productModels.add(model);
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel!.name),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.indigo,
              ],
            ),
          ),
        ),
      ),
      body: load
          ? ShowProgress()
          : haveProduct!
              ? listProduct()
              : Center(
                  child: ShowTitle(
                    title: 'ไม่มีสินค้า !!!',
                    textStyle: MyConstant().h1Style(),
                  ),
                ),
    );
  }

  LayoutBuilder listProduct() {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            //print('### You Click Index ==>> $index');
            showAlertDialog(
              productModels[index],
              listImages[index],
            );
          },
          child: Card(
            child: Row(
              children: [
                Container(
                  width: constraints.maxWidth * 0.5 - 8,
                  height: constraints.maxWidth * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: findUrlImage(productModels[index].images),
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) =>
                          ShowImage(path: MyConstant.motocycle),
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.5,
                  height: constraints.maxWidth * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowTitle(
                          title: productModels[index].name,
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowTitle(
                          title: 'ราคา ${productModels[index].price} บาท',
                          textStyle: MyConstant().h3Style(),
                        ),
                        ShowTitle(
                          title: 'รายละเอียดสินค้า :',
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowTitle(
                          title: cutWord('${productModels[index].detail}'),
                          textStyle: MyConstant().h3Style(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String findUrlImage(String arrayImage) {
    String string = arrayImage.substring(1, arrayImage.length - 1);
    List<String> strings = string.split(',');
    int index = 0;
    for (var item in strings) {
      strings[index] = item.trim();
      index++;
    }
    return '${MyConstant.domain}/shops/img/products/${strings[0]}';
  }

  Future<Null> showAlertDialog(
      ProductModel productModel, List<String> images) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: ListTile(
            leading: ShowImage(path: MyConstant.motocycle),
            title: ShowTitle(
              title: productModel.name,
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ราคา ${productModel.price} บาท',
              textStyle: MyConstant().h3Style(),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      '${MyConstant.domain}/shops/img/products/${images[indexImage]}',
                  placeholder: (context, url) => ShowProgress(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            indexImage = 0;
                            //print('### indexImage ==>> $indexImage');
                          });
                        },
                        icon: Icon(Icons.filter_1),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            indexImage = 1;
                            //print('### indexImage ==>> $indexImage');
                          });
                        },
                        icon: Icon(Icons.filter_2),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            indexImage = 2;
                            //print('### indexImage ==>> $indexImage');
                          });
                        },
                        icon: Icon(Icons.filter_3),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            indexImage = 3;
                            //print('### indexImage ==>> $indexImage');
                          });
                        },
                        icon: Icon(Icons.filter_4),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ShowTitle(
                      title: 'รายละเอียดสินค้า :',
                      textStyle: MyConstant().h2Style(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        child: ShowTitle(
                          title: productModel.detail,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (amountInt != 1) {
                          setState(() {
                            amountInt--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.blue,
                      ),
                    ),
                    ShowTitle(
                      title: amountInt.toString(),
                      textStyle: MyConstant().h1Style(),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          amountInt++;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    String idSeller = userModel!.id;
                    String idProduct = productModel.id;
                    String name = productModel.name;
                    String price = productModel.price;
                    String amount = amountInt.toString();
                    int sumInt = int.parse(price) * amountInt;
                    String sum = sumInt.toString();
                    if ((currentIdSeller == idSeller) ||
                        (currentIdSeller == null)) {
                      SQLiteModel sqLiteModel = SQLiteModel(
                          idSeller: idSeller,
                          idProduct: idProduct,
                          name: name,
                          price: price,
                          amount: amount,
                          sum: sum);
                      await SQLiteHelper()
                          .insertValueToSQLite(sqLiteModel)
                          .then((value) {
                        amountInt = 1;
                        Navigator.pop(context);
                      });
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      MyDialog().normalDialog(context, 'ร้านผิด ?',
                          'กรุณาเลือกสินค้าที่ ร้านเดิม ให้เสร็จก่อน เลือกร้านอื่น');
                    }
                  },
                  child: Text(
                    'เพิ่มลงรถเข็น',
                    style: MyConstant().h2BlueStyle(),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'ยกเลิก',
                    style: MyConstant().h2OrangeStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String cutWord(String string) {
    String result = string;
    if (result.length >= 100) {
      result = result.substring(0, 100);
      result = '$result ...';
    }
    return result;
  }
}
