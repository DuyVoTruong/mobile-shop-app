import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/login_page.dart';

class AppBarShop extends StatelessWidget with PreferredSizeWidget{

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context){

    void handleClick(int value, context) {
      switch (value) {
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          break;
        case 1:
          Get.toNamed(AppRoutes.sellerHome);
          break;
      }
    }

    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.black12,
      title: Text("Mobile Shop", style: TextStyle(color: Colors.black),),
      actions: <Widget>[
        SizedBox(
          width: 250,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Search',
              ),
            ),
          ),
        ),
        PopupMenuButton<int>(
          onSelected: (item) => handleClick(item, context),
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Text('Login')),
            PopupMenuItem<int>(value: 1, child: Text('Seller')),
          ],
        ),
      ],
    );
  }
}