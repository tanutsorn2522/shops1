import 'package:flutter/material.dart';
import 'package:shops/utility/my_constant.dart';

class ShowProductSeller extends StatefulWidget {
  ShowProductSeller({Key? key}) : super(key: key);

  @override
  State<ShowProductSeller> createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Show Product'),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduce),
        child: Text('Add'),
      ),
    );
  }
}
