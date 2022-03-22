import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/utility/my_dialog.dart';
import 'package:shops/widgets/show_image.dart';
import 'package:shops/widgets/show_title.dart';

class ConfirmAddWallet extends StatefulWidget {
  const ConfirmAddWallet({Key? key}) : super(key: key);

  @override
  State<ConfirmAddWallet> createState() => _ConfirmAddWalletState();
}

class _ConfirmAddWalletState extends State<ConfirmAddWallet> {
  String? dateTimeStr;
  File? file;
  var formKey = GlobalKey<FormState>();
  String? idBuyer;
  TextEditingController moneyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findCurrentTime();
    findIdBuyer();
  }

  Future<void> findIdBuyer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idBuyer = preferences.getString('id');
  }

  void findCurrentTime() {
    DateTime dateTime = DateTime.now();

    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    dateTimeStr = dateFormat.format(dateTime);
    //print('dateTimeStr ==>> $dateTimeStr');
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                newHeader(),
                newDateTimePay(),
                Spacer(),
                newMoney(),
                Spacer(),
                newImage(),
                Spacer(),
                newButtonConfirm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row newMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: TextFormField(
            controller: moneyController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกจำนวนเงิน';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              label: ShowTitle(
                title: 'Money',
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Container newButtonConfirm() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (file == null) {
              MyDialog().normalDialog(context, 'ยังไม่มีรูปภาพ',
                  'กรุณา ถ่ายภาพ หรือ ใช้ภาพจากคลังภาพ');
            } else {
              processUploadAndInsertData();
            }
          }
        },
        child: Text('Confirm Add Wallet'),
      ),
    );
  }

  Future<void> processUploadAndInsertData() async {
    // upload Image to Server
    String APIsaveSlip = '${MyConstant.domain}/shops/savebill.php';
    String nameSlip = 'bill${Random().nextInt(1000000)}.jpg';

    MyDialog().showProgressDialog(context);

    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameSlip);
      FormData data = FormData.fromMap(map);
      await Dio().post(APIsaveSlip, data: data).then((value) async {
        //print('value ==>> $value');
        Navigator.pop(context);

        // insert value to mySQL
        var status = 'WaitOrder';
        var urlAPIinsert =
            '${MyConstant.domain}/shops/insertWallet.php?isAdd=true&idBuyer=$idBuyer&datePay=$dateTimeStr&money=${moneyController.text.trim()}&pathbill=$nameSlip&status=$status';
        await Dio().get(urlAPIinsert).then(
              (value) => MyDialog().actionDialog(
                  context, 'ยืนยันสำเร็จ', 'ยืนยันการโอนเงินสำเร็จ', () {
                Navigator.pop(context);
              }),
            );
      });
    } catch (e) {}
  }

  Future<void> ProcessTakePhoto(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row newImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => ProcessTakePhoto(ImageSource.camera),
          icon: Icon(Icons.add_a_photo),
        ),
        Container(
          width: 180,
          height: 180,
          child: file == null
              ? ShowImage(path: 'images/bill.png')
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => ProcessTakePhoto(ImageSource.gallery),
          icon: Icon(Icons.add_photo_alternate),
        ),
      ],
    );
  }

  ShowTitle newDateTimePay() {
    return ShowTitle(
      title: dateTimeStr == null ? 'dd/MM/yyyy HH:mm' : dateTimeStr!,
      textStyle: MyConstant().h2Style(),
    );
  }

  ShowTitle newHeader() {
    return ShowTitle(
      title: 'Current Date Pay',
      textStyle: MyConstant().h1Style(),
    );
  }
}
