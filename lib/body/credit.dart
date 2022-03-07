import 'package:flutter/material.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_title.dart';

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  String? name, surname, idCard, expiryDateMouth, expiryDateYear, cvc, amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle('ชื่อ - นามสกุล'),
            buildNameSurname(),
            buildTitle('หมายเลข บัตรเครดิต'),
            formIdcard(),
            buildExpiryCvc(),
            buildTitle('จำนวนเงิน'),
            formAmount(),
            Spacer(),
            buttonAddMoney(),
          ],
        ),
      ),
    );
  }

  Padding buttonAddMoney() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            print('value idCard ==>> $idCard');
          },
          child: Text('Add Money'),
        ),
      ),
    );
  }

  Container buildExpiryCvc() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizebox(30),
          Expanded(
            child: Column(
              children: [
                buildTitle('Expiry Date'),
                formExpiryDate(),
              ],
            ),
          ),
          buildSizebox(8),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC'),
                formCVC(),
              ],
            ),
          ),
          buildSizebox(30),
        ],
      ),
    );
  }

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizebox(30),
          formName(),
          buildSizebox(8),
          formSurName(),
          buildSizebox(30),
        ],
      ),
    );
  }

  SizedBox buildSizebox(double width) {
    return SizedBox(
      width: 30,
    );
  }

  Widget formIdcard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          onChanged: (value) {
            idCard = value.trim();
            //print('value idCard ==>> $value');
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'xxxx-xxxx-xxxx-xxxx',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      );

  Widget formAmount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffix: ShowTitle(
              title: 'THB.',
              textStyle: MyConstant().h2Style(),
            ),
            label: ShowTitle(title: 'จำนวนเงิน'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      );

  Widget formExpiryDate() => TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'DD/YYYY',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );

  Widget formCVC() => TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxx',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );

  Widget formName() => Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            label: ShowTitle(
              title: 'ชื่อ',
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      );

  Widget formSurName() => Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            label: ShowTitle(
              title: 'นามสกุล',
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      );

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2BlueStyle(),
      ),
    );
  }
}
