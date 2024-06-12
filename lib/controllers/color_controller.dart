import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';

class ColorModel{
  String color;
  bool isCheck;

  ColorModel({required this.color, required this.isCheck});
  @override
  String toString() => "Record<$color:$isCheck>";
}

class ColorController extends GetxController{

  static ProductController productController = Get.put(ProductController());
  static BrandController brandController = Get.put(BrandController());
  static PriceController priceController = Get.put(PriceController());
  static RamController ramController = Get.put(RamController());
  static RomController romController = Get.put(RomController());
  static SearchController searchController = Get.put(SearchController());

  RxList<ColorModel> color = RxList<ColorModel>([
    ColorModel(color: 'Trắng', isCheck: false),
    ColorModel(color: 'Đen', isCheck: false),
    ColorModel(color: 'Xanh', isCheck: false),
    ColorModel(color: 'Xanh lá', isCheck: false),
    ColorModel(color: 'Vàng', isCheck: false),
    ColorModel(color: 'Tất cả', isCheck: true),
  ]);

  RxString colorSelected = RxString('Tất cả');

  void selectColor(index){
    for(int i=0;i<color.length;i++){
      color[i].isCheck=false;
    }
    color[index].isCheck=true;
    color.refresh();
    colorSelected.value=color[index].color;
    update();
    productController.filterProduct(brandController.brandSelected, colorSelected, priceController.priceSelected, ramController.ramSelected, romController.romSelected);
  }

  void resetColor(){
    colorSelected.value = 'Tất cả';
    for(int i=0;i<color.length;i++){
      color[i].isCheck=false;
    }
    color[color.length-1].isCheck=true;
    update();
    color.refresh();
  }

}