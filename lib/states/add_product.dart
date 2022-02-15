import 'package:flutter/material.dart';
import 'package:shops/utility/my_constant.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildProductName(constraints),
                  buildProductPrice(constraints),
                  buildProductDetail(constraints),
                  buildImage(constraints),
                  Container(
                    width: constraints.maxWidth * 0.75,
                    child: ElevatedButton(
                      style: MyConstant().myButtonStyle(),
                      onPressed: () {},
                      child: Text('เพิ่มสินค้า'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          height: constraints.maxWidth * 0.75,
          child: Image.asset(MyConstant.folderimage),
        ),
        Container(
          width: constraints.maxWidth * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: Image.asset(MyConstant.imageicon2),
              ),
              Container(
                width: 48,
                height: 48,
                child: Image.asset(MyConstant.imageicon2),
              ),
              Container(
                width: 48,
                height: 48,
                child: Image.asset(MyConstant.imageicon2),
              ),
              Container(
                width: 48,
                height: 48,
                child: Image.asset(MyConstant.imageicon2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'ชื่อสินค้า',
          prefixIcon: Icon(
            Icons.production_quantity_limits_sharp,
            color: MyConstant.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildProductPrice(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: MyConstant().h3Style(),
          labelText: 'ราคาสินค้า',
          prefixIcon: Icon(
            Icons.money_sharp,
            color: MyConstant.dark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 16),
      child: TextFormField(
        maxLines: 4,
        decoration: InputDecoration(
          hintStyle: MyConstant().h3Style(),
          hintText: 'รายละเอียดสินค้า',
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Icon(
              Icons.details_outlined,
              color: MyConstant.dark,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
