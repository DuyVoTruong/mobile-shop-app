import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';

class RomModel{
  String rom;
  bool isCheck;

  RomModel({required this.rom, required this.isCheck});
  @override
  String toString() => "Record<$rom:$isCheck>";
}

class RomController extends GetxController{

  static ProductController productController = Get.put(ProductController());
  static BrandController brandController = Get.put(BrandController());
  static PriceController priceController = Get.put(PriceController());
  static ColorController colorController = Get.put(ColorController());
  static RamController ramController = Get.put(RamController());

  RxList<RomModel> rom = RxList<RomModel>([
    RomModel(rom: '32G', isCheck: false),
    RomModel(rom: '64G', isCheck: false),
    RomModel(rom: '128G', isCheck: false),
    RomModel(rom: '256G', isCheck: false),
    RomModel(rom: '512G', isCheck: false),
    RomModel(rom: '1TB', isCheck: false),
    RomModel(rom: 'Tất cả', isCheck: true),
  ]);

  RxString romSelected = RxString('Tất cả');

  void selectRom(index){
    for(int i=0;i<rom.length;i++){
      rom[i].isCheck=false;
    }
    rom[index].isCheck=true;
    rom.refresh();
    romSelected.value=rom[index].rom;
    update();
    productController.filterProduct(brandController.brandSelected, colorController.colorSelected, priceController.priceSelected, ramController.ramSelected, romSelected);
  }

  void resetRom(){
    romSelected.value='Tất cả';
    for(int i=0;i<rom.length;i++){
      rom[i].isCheck=false;
    }
    rom[rom.length-1].isCheck=true;
    update();
    rom.refresh();
  }

}