import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';

class SearchController extends GetxController{

  static ProductController productController = Get.put(ProductController());
  static BrandController brandController = Get.put(BrandController());
  static PriceController priceController = Get.put(PriceController());
  static ColorController colorController = Get.put(ColorController());
  static RamController ramController = Get.put(RamController());
  static RomController romController = Get.put(RomController());
  RxString searchText = RxString('');

  void search(text){
    productController.searchName(text);
    searchText.value = text;
    update();
    //productController.filterProduct(brandController.brandSelected, colorController.colorSelected, priceController.price, ramController.ramSelected, romController.romSelected);
  }

}