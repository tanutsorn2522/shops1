import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shops/models/product_model.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_title.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;

  const EditProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ProductModel? productModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  List<String> pathImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productModel = widget.productModel;
    //print('## image from mysql ==>> ${productModel!.images}');
    convertStringToArray();
    nameController.text = productModel!.name;
    priceController.text = productModel!.price;
    detailController.text = productModel!.detail;
  }

  void convertStringToArray() {
    String string = productModel!.images;
    //print('Sting ก่อนตัด ==>> $string');
    string = string.substring(1, string.length - 1);
    //print('Sting หลังตัด ==>> $string');
    List<String> strings = string.split(',');
    for (var item in strings) {
      pathImages.add(item.trim());
    }
    print('### pathImages ==>> $pathImages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle('General'),
                buidName(constraints),
                buidPrice(constraints),
                buidDetail(constraints),
                buildTitle('Images Product'),
                buildImage(constraints, 0),
                buildImage(constraints, 1),
                buildImage(constraints, 2),
                buildImage(constraints, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildImage(BoxConstraints constraints, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_a_photo),
          ),
          Container(
            width: constraints.maxWidth * 0.5,
            child: CachedNetworkImage(
              imageUrl:
                  '${MyConstant.domain}/shops/img/products/${pathImages[index]}',
              placeholder: (context, url) => ShowProgress(),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
    );
  }

  Row buidName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'ชื่อสินค้า',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buidPrice(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'ราคาสินค้า',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buidDetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            maxLines: 3,
            controller: detailController,
            decoration: InputDecoration(
              labelText: 'ข้อมูลสินค้า',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitle(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
        ),
      ],
    );
  }
}
