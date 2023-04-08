import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/bottom_nav_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class BottomBar extends StatelessWidget{

  BottomNavController controller = Get.put(BottomNavController());

  void selectedItem(index){
    controller.selectIndex(index);
    if(index==0){
      Get.toNamed(AppRoutes.home);
    } else if(index==1){
      Get.toNamed(AppRoutes.history);
    } else if(index==2){
      Get.toNamed(AppRoutes.cart);
    }
  }

  @override
  Widget build(BuildContext context){
    return Obx(() => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: controller.index.value,
        selectedItemColor: Colors.amber[800],
        onTap: selectedItem,
      ),
    );
  }
}