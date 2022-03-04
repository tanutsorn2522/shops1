import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_title.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [buildTitle(), buildKbank()],
      ),
    );
  }

  Widget buildKbank() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      height: 150,
      child: Center(
        child: Card(
          color: Colors.green.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                width: 80,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 153, 51, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('images/kbank.svg'),
                ),
              ),
              title: ShowTitle(
                title: 'ธนาคารกสิกรไทย           สาขาสว่างแดนดิน',
                textStyle: MyConstant().h2Style(),
              ),
              subtitle: ShowTitle(
                title:
                    'ชื่อบัญชี บริษัท ชาญยนต์ 2005 จำกัด เลขที่บัญชี 000 - 0 - 00000 - 0',
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: 'การโอนเงินเข้า บัญชีธนาคาร',
        textStyle: MyConstant().h1Style(),
      ),
    );
  }
}
