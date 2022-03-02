import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/utility/my_constant.dart';
import 'package:shops/widgets/show_title.dart';

class showSignOut extends StatelessWidget {
  const showSignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.indigo],
            ),
          ),
          child: ListTile(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear().then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                        context, MyConstant.routeAuthen, (route) => false),
                  );
            },
            tileColor: Colors.red.shade400,
            leading: Icon(
              Icons.exit_to_app,
              size: 36,
              color: Colors.white,
            ),
            title: ShowTitle(
              title: 'Sign Out',
              textStyle: MyConstant().h2WhiteStyle(),
            ),
            subtitle: ShowTitle(
              title: 'Sign Out And Go to Authen',
              textStyle: MyConstant().h3WhiteStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
