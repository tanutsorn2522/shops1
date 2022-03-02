import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shops/models/sqlite_model.dart';
import 'package:shops/models/user_model.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/utility/sqlite_helper.dart';
import 'package:shops/widgets/show_image.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_title.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  UserModel? userModel;
  int? total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }
    await SQLiteHelper().readSQLite().then((value) {
      setState(() {
        load = false;
        sqliteModels = value;
        findDetailSeller();
        calsulateTotal();
      });
    });
  }

  void calsulateTotal() async {
    total = 0;
    for (var item in sqliteModels) {
      int sumInt = int.parse(item.sum.trim());
      setState(() {
        total = total! + sumInt;
      });
    }
  }

  Future<void> findDetailSeller() async {
    String idSeller = sqliteModels[0].idSeller;
    //print('### idSeller ==>> $idSeller');
    String apiGetUserWhereId =
        '${MyConstant.domain}/shops/getUserWhereId.php?isAdd=true&id=$idSeller';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Cart'),
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
          : sqliteModels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: 200,
                        child: ShowImage(path: MyConstant.image4),
                      ),
                      ShowTitle(
                          title: 'ยังไม่สินค้าในรถเข็น',
                          textStyle: MyConstant().h1Style()),
                    ],
                  ),
                )
              : buildContent(),
    );
  }

  SingleChildScrollView buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showSeller(),
          buildHead(),
          listProduct(),
          buildDivider(),
          buildTotal(),
          buildDivider(),
          buttonController(),
        ],
      ),
    );
  }

  Future<void> confirmEmptyCart() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image2),
          title: ShowTitle(
              title: 'คุณต้องการจะ ลบ ?',
              textStyle: MyConstant().h2BlueStyle()),
          subtitle: ShowTitle(
            title: 'รายการสั่งสินค้าทั้งหมดในรถเข็น ใช่ หรือ ไม่',
            textStyle: MyConstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await SQLiteHelper().emptySQLite().then((value) {
                Navigator.pop(context);
                processReadSQLite();
              });
            },
            child: Text('ลบทั้งหมด'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ยกเลิก'),
          ),
        ],
      ),
    );
  }

  Row buttonController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('สั่งสินค้า'),
        ),
        Container(
          margin: EdgeInsets.only(left: 4, right: 8),
          child: ElevatedButton(
            onPressed: () => confirmEmptyCart(),
            child: Text('ลบทั้งหมด'),
          ),
        ),
      ],
    );
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Tetal :',
                textStyle: MyConstant().h2BlueStyle(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: total == null ? '' : total.toString(),
                textStyle: MyConstant().h1Style(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Divider buildDivider() {
    return Divider(
      color: MyConstant.dark,
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShowTitle(
                title: sqliteModels[index].name,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].price,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].amount,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].sum,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                int idSQLite = sqliteModels[index].id!;
                //print('### Delete idSQLite ==>> $idSQLite');
                await SQLiteHelper()
                    .deleteSQLiteWhereId(idSQLite)
                    .then((value) => processReadSQLite());
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHead() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyan,
            Colors.lightBlue.shade100,
            Colors.cyan,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ShowTitle(
                  title: 'สินค้า',
                  textStyle: MyConstant().h2Style(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'ราคา',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'จำนวน',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'รวม',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Padding showSeller() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: userModel == null ? '' : userModel!.name,
        textStyle: MyConstant().h1Style(),
      ),
    );
  }
}
