import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';

class PriceModel{
  String title;
  int value;
  bool isCheck;

  PriceModel({required this.title, required this.value, required this.isCheck});

}

class PriceController extends GetxController{

  static ProductController productController = Get.put(ProductController());
  static BrandController brandController = Get.put(BrandController());
  static ColorController colorController = Get.put(ColorController());
  static RamController ramController = Get.put(RamController());
  static RomController romController = Get.put(RomController());

  RxList<PriceModel> price = RxList<PriceModel>([
    PriceModel(title: 'Dưới 2 triệu', value: 1, isCheck: false),
    PriceModel(title: 'Từ 2 triệu đến 4 triệu', value: 2, isCheck: false),
    PriceModel(title: 'Từ 4 triệu đến 7 triệu', value: 3, isCheck: false),
    PriceModel(title: 'Từ 7 triệu đến 13 triệu', value: 4, isCheck: false),
    PriceModel(title: 'Trên 13 triệu', value: 5, isCheck: false),
    PriceModel(title: 'Tất cả', value: 6, isCheck: true),
  ]);

  RxInt priceSelected = RxInt(6);

  void selectPrice(index){
    for(int i=0;i<price.length;i++){
      price[i].isCheck=false;
    }
    price[index].isCheck=true;
    price.refresh();
    priceSelected.value=price[index].value;
    update();
    productController.filterProduct(brandController.brandSelected, colorController.colorSelected, priceSelected, ramController.ramSelected, romController.romSelected);
  }

  void resetPrice(){
    priceSelected.value = 6;
    for(int i=0;i<price.length;i++){
      price[i].isCheck=false;
    }
    price[price.length-1].isCheck=true;
    update();
    price.refresh();
  }

}