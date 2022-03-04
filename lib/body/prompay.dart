import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/utility/my_dialog.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_title.dart';

class Prompay extends StatefulWidget {
  const Prompay({Key? key}) : super(key: key);

  @override
  State<Prompay> createState() => _PrompayState();
}

class _PrompayState extends State<Prompay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTitle(),
            buildCopyPrompay(),
            buildQRcodePromptpay(),
            buildDownload(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildDownload() => ElevatedButton(
        onPressed: () async {
          String path = '/sdcard/download';
          try {
            await FileUtils.mkdir([path]);
            await Dio()
                .download(MyConstant.urlPromptpay, '$path/promptpay.png')
                .then(
                  (value) => MyDialog().normalDialog(
                      context,
                      'ดาวน์โหลด PromptPay สำเร็จ',
                      'กรุณาไปที่แอพธนาคา เพื่ออ่าน QRcode ที่โหลดมา'),
                );
          } catch (e) {
            //print('## error ===>>> ${e.toString()}');
            MyDialog().normalDialog(context, 'Storage Permission Denied',
                'กรุณาเปิด Permission Storage');
          }
        },
        child: Text('Download QRcode'),
      );

  Container buildQRcodePromptpay() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        imageUrl: MyConstant.urlPromptpay,
        placeholder: (context, url) => ShowProgress(),
      ),
    );
  }

  Widget buildCopyPrompay() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Card(
        color: Colors.lightBlue.shade100,
        child: ListTile(
          title: ShowTitle(
            title: '0973075354',
            textStyle: MyConstant().h1Style(),
          ),
          subtitle: ShowTitle(title: 'บัญชี PromptPay'),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: '0973075354'));
              MyDialog().normalDialog(context, 'Copy PromptPay',
                  'Copy PromptPay to Clopboard สำเร็จแล้ว กรุณาไปที่ แอพธนาคารของท่าน เพื่อโอนเงิน');
            },
            icon: Icon(Icons.copy),
          ),
        ),
      ),
    );
  }

  ShowTitle buildTitle() {
    return ShowTitle(
      title: 'การโอนเงินโดยใช้ Promptpay',
      textStyle: MyConstant().h2Style(),
    );
  }
}
