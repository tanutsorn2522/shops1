import 'package:flutter/material.dart';
import 'package:shops/body/bank.dart';
import 'package:shops/body/credit.dart';
import 'package:shops/body/prompay.dart';
import 'package:shops/utility/my_constant.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    Bank(),
    Prompay(),
    Credit(),
  ];
  List<IconData> icons = [
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.credit_card,
  ];
  List<String> titles = ['Bank', 'PromptPay', 'Credit'];
  int indexPosition = 0;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0;
    for (var item in titles) {
      bottomNavigationBarItems.add(
        createBottomNavigationBarItem(icons[i], item),
      );
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text('Add Wallet from ${titles[indexPosition]}'),
      ),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MyConstant.dark,
        unselectedItemColor: MyConstant.light,
        currentIndex: indexPosition,
        items: bottomNavigationBarItems,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
