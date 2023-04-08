import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/bottom_nav_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => ProductController());
  }
}