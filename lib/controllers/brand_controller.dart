import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';

class BrandModel{
  String link;
  bool isCheck;
  String brand;

  BrandModel({required this.link, required this.isCheck, required this.brand});
  @override
  String toString() => "Record<$link:$isCheck:$brand>";
}

class BrandController extends GetxController{

  static ProductController productController = Get.put(ProductController());
  static PriceController priceController = Get.put(PriceController());
  static ColorController colorController = Get.put(ColorController());
  static RamController ramController = Get.put(RamController());
  static RomController romController = Get.put(RomController());
  static SearchController searchController = Get.put(SearchController());

  RxList<BrandModel> brand = RxList<BrandModel>([
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/logo-iphone-220x48.png', isCheck: false, brand: 'Iphone'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/samsungnew-220x48-1.png', isCheck: false, brand: 'Samsung'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/OPPO42-b_5.jpg', isCheck: false, brand: 'Oppo'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/logo-xiaomi-220x48-5.png', isCheck: false, brand: 'Xiaomi'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/vivo-logo-220-220x48-3.png', isCheck: false, brand: 'Vivo'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/Realme42-b_37.png', isCheck: false, brand: 'Realme'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/Nokia42-b_21.jpg', isCheck: false, brand: 'Nokia'),
    BrandModel(link: 'https://cdn.tgdd.vn/Brand/1/Mobell42-b_19.jpg', isCheck: false, brand: 'Mobell'),
  ]);

  RxList brandSelected = RxList([]);

  void selectBrand(index){
    brand[index].isCheck=!brand[index].isCheck;
    brand.refresh();
    if(brand[index].isCheck==true){
      brandSelected.add(brand[index].brand);
    } else {
      brandSelected.remove(brand[index].brand);
    }
    update();
    productController.filterProduct(brandSelected, colorController.colorSelected, priceController.priceSelected, ramController.ramSelected, romController.romSelected);
  }

  void resetBrand(){
    brandSelected.clear();
    for(int i=0; i<brand.length; i++){
      brand[i].isCheck=false;
    }
    update();
    brand.refresh();
  }

}