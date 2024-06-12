import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';

class RamModel{
  String ram;
  bool isCheck;

  RamModel({required this.ram, required this.isCheck});
  @override
  String toString() => "Record<$ram:$isCheck>";
}

class RamController extends GetxController{

  static ProductController productController = Get.put(ProductController());
  static BrandController brandController = Get.put(BrandController());
  static PriceController priceController = Get.put(PriceController());
  static ColorController colorController = Get.put(ColorController());
  static RomController romController = Get.put(RomController());

  RxList<RamModel> ram = RxList<RamModel>([
    RamModel(ram: '2G', isCheck: false),
    RamModel(ram: '3G', isCheck: false),
    RamModel(ram: '4G', isCheck: false),
    RamModel(ram: '6G', isCheck: false),
    RamModel(ram: '8G', isCheck: false),
    RamModel(ram: '12G', isCheck: false),
    RamModel(ram: 'Tất cả', isCheck: true),
  ]);

  RxString ramSelected = RxString('Tất cả');

  void selectRam(index){
    for(int i=0;i<ram.length;i++){
      ram[i].isCheck=false;
    }
    ram[index].isCheck=true;
    ram.refresh();
    ramSelected.value=ram[index].ram;
    update();
    productController.filterProduct(brandController.brandSelected, colorController.colorSelected, priceController.priceSelected, ramSelected, romController.romSelected);
  }

  void resetRam(){
    ramSelected.value='Tất cả';
    for(int i=0;i<ram.length;i++){
      ram[i].isCheck=false;
    }
    ram[ram.length-1].isCheck=true;
    update();
    ram.refresh();
  }

}