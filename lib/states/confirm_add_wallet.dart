import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_title.dart';

class ConfirmAddWallet extends StatefulWidget {
  const ConfirmAddWallet({Key? key}) : super(key: key);

  @override
  State<ConfirmAddWallet> createState() => _ConfirmAddWalletState();
}

class _ConfirmAddWalletState extends State<ConfirmAddWallet> {
  late String dateTimeStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findCurrentTime();
  }

  void findCurrentTime() {
    DateTime dateTime = DateTime.now();

    dateTimeStr = dateTime.toString();
    print('dateTimeStr ==>> $dateTimeStr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Add Wallet'),
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeBuyerService, (route) => false),
          icon: Platform.isIOS
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowTitle(
            title: 'Current Date Pay',
            textStyle: MyConstant().h1Style(),
          ),
          ShowTitle(
            title: 'dd/mm/yy HH:mm',
            textStyle: MyConstant().h2Style(),
          )
        ],
      ),
    );
  }
}
