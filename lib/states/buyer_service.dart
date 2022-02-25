import 'package:flutter/material.dart';
import 'package:shops/body/my_money_buyer.dart';
import 'package:shops/body/my_order_buyer.dart';
import 'package:shops/body/show_all_product_buyer.dart';
import 'package:shops/states/show_cart.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_signout.dart';
import 'package:shops/widgets/show_title.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  List<Widget> widgets = [
    ShowAllProductBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, MyConstant.routeShowCart),
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllProduct(),
                menuMyMoney(),
                menuMyOrder(),
              ],
            ),
            showSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowAllProduct() {
    return ListTile(
      leading: Icon(
        Icons.motorcycle,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'Show All Product',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงสินค้า ทั้งหมด',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.money,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'My Money',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงจำนวนเงินของฉัน',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.shopping_basket,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'My Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการสั่งสินค้า',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
