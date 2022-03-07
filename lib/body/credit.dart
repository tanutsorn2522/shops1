import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_title.dart';

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  String? name,
      surname,
      idCard,
      expiryDateMouth,
      expiryDateYear,
      cvc,
      amount,
      expiryDateStr;
  MaskTextInputFormatter idCardMask =
      MaskTextInputFormatter(mask: '#### - #### - #### - ####');
  MaskTextInputFormatter expiryDateMask =
      MaskTextInputFormatter(mask: '## / ####');
  MaskTextInputFormatter cvcMask = MaskTextInputFormatter(mask: '###');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                buttonAddMoney(),
              ],
            ),
          ),
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
            if (formKey.currentState!.validate()) {
              expiryDateMouth = expiryDateStr!.substring(0, 2);
              expiryDateYear = expiryDateStr!.substring(2, 6);
              print(
                  'idCard ==>> $idCard, expiryDateMouth ==>> $expiryDateMouth, expiryDateYear ==>> $expiryDateYear, cvc ==>> $cvc');
            }
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาใส่หมายเลขบัตรเครดิต';
            } else {
              if (idCard!.length != 16) {
                return 'หมายเลขบัตร ต้องมี 16 ตัวอักษร';
              } else {
                return null;
              }
            }
          },
          inputFormatters: [idCardMask],
          onChanged: (value) {
            //idCard = value.trim();
            //print('value idCard ==>> $value');
            idCard = idCardMask.getUnmaskedText();
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'xxxx - xxxx - xxxx - xxxx',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      );

  Widget formAmount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาใส่ จำนวนเงิน';
            } else {
              return null;
            }
          },
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาใส่ เดือน/ปี หมดอายุ';
          } else {
            if (expiryDateStr!.length != 6) {
              return 'กรุณาใส่ให้ครบ';
            } else {
              return null;
            }
          }
        },
        onChanged: (value) {
          expiryDateStr = expiryDateMask.getUnmaskedText();
        },
        inputFormatters: [expiryDateMask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'MM / YYYY',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );

  Widget formCVC() => TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาใส่หมายเลขหลังบัตร';
          } else {
            if (cvc!.length != 3) {
              return 'ต้องมี 3 ตัวอักษร';
            } else {
              return null;
            }
          }
        },
        onChanged: (value) {
          cvc = cvcMask.getUnmaskedText();
        },
        inputFormatters: [cvcMask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxx',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );

  Widget formName() => Expanded(
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาใส่ชื่อ';
            } else {
              return null;
            }
          },
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณาใส่นามสกุล';
            } else {
              return null;
            }
          },
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
