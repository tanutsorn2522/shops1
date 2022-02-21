import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shops/models/user_model.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_progress.dart';
import 'package:shops/widgets/show_title.dart';

class ShowManageSeller extends StatefulWidget {
  final UserModel userModel;
  const ShowManageSeller({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ShowManageSeller> createState() => _ShowManageSellerState();
}

class _ShowManageSellerState extends State<ShowManageSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.primary,
        child: Icon(Icons.edit),
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeEditProfileSeller),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowTitle(
                    title: 'ชื่อร้านค้า :', textStyle: MyConstant().h2Style()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShowTitle(
                          title: userModel!.name,
                          textStyle: MyConstant().h1Style()),
                    ),
                  ],
                ),
                ShowTitle(
                    title: 'ที่อยู่ :', textStyle: MyConstant().h2Style()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShowTitle(
                          title: userModel!.address,
                          textStyle: MyConstant().h2Style(),
                        ),
                      ),
                    ),
                  ],
                ),
                ShowTitle(
                  title: 'เบอร์โทรศัพท์ : ${userModel!.phone}',
                  textStyle: MyConstant().h2Style(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ShowTitle(
                    title: 'รูปภาพ :',
                    textStyle: MyConstant().h2Style(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      width: constraints.maxWidth * 0.6,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${MyConstant.domain}/shops/img/avatar/${userModel!.avatar}',
                        placeholder: (context, url) => ShowProgress(),
                      ),
                    ),
                  ],
                ),
                ShowTitle(
                  title: 'แผนที่ :',
                  textStyle: MyConstant().h2Style(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      width: constraints.maxWidth * 0.6,
                      height: constraints.maxWidth * 0.6,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(userModel!.lat),
                            double.parse(userModel!.lng),
                          ),
                          zoom: 16,
                        ),
                        markers: <Marker>[
                          Marker(
                              markerId: MarkerId('id'),
                              position: LatLng(
                                double.parse(userModel!.lat),
                                double.parse(userModel!.lng),
                              ),
                              infoWindow: InfoWindow(
                                  title: 'คุณอยู่ที่นี่',
                                  snippet:
                                      'Lat = ${userModel!.lat}, Lng = ${userModel!.lng}')),
                        ].toSet(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
