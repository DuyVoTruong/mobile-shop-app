import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class AppBarShop extends StatelessWidget with PreferredSizeWidget{
  const AppBarShop({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context){

    CartController cartController = Get.put(CartController());

    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.black12,
      //title: Text("Mobile Shop", style: TextStyle(color: Colors.black),),
      title: const Text('Mobile Shop', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        IconButton(
            onPressed: (){
              Get.toNamed(AppRoutes.search);
            },
            icon: const Icon(Icons.search)
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            IconButton(
              color: Colors.black54,
              onPressed: (){
                Get.toNamed(AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart)
            ),
            Obx(() => Positioned(
              right: 2,
              top: 8,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                child: Text('${cartController.tongSoLuong.value}', style: const TextStyle(fontSize: 8),),
              ),
            )),
          ],
        )
      ],
    );
  }
}