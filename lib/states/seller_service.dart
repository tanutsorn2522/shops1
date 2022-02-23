import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/body/show_manage_seller.dart';
import 'package:shops/body/show_order_seller.dart';
import 'package:shops/body/show_product_seller.dart';
import 'package:shops/models/user_model.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_signout.dart';
import 'package:shops/widgets/show_title.dart';

class SellerService extends StatefulWidget {
  const SellerService({Key? key}) : super(key: key);

  @override
  _SellerServiceState createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  List<Widget> widgets = [];
  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    String apiGetUserWhereId =
        '${MyConstant.domain}/shops/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          widgets.add(ShowOrderSeller());
          widgets.add(ShowManageSeller(userModel: userModel!));
          widgets.add(ShowProductSeller());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
      ),
      drawer: widgets.length == 0
          ? SizedBox()
          : Drawer(
              child: Stack(
                children: [
                  showSignOut(),
                  Column(
                    children: [
                      buildHead(),
                      menuShowOrder(),
                      menuShowManage(),
                      menuShowProduct(),
                    ],
                  ),
                ],
              ),
            ),
      body: widgets.length == 0 ? ShowProgress() : widgets[indexWidget],
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
      otherAccountsPictures: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.home_work_sharp),
          iconSize: 32,
          color: MyConstant.light,
          tooltip: 'Edit Shop',
        ),
      ],
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [MyConstant.light, MyConstant.dark],
          center: Alignment(-0.8, -0.2),
          radius: 1,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
            '${MyConstant.domain}/shops/img/avatar/${userModel!.avatar}'),
      ),
      accountName: Text(userModel == null ? 'name ?' : userModel!.name),
      accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type),
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของออเดอร์',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2),
      title: ShowTitle(
        title: 'Show Manage',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของหน้าร้าน',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของสินค้า',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }
}
