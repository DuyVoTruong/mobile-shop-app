import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/show_dialog_loading.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static BrandController brandController = Get.put(BrandController());
  static PriceController priceController = Get.put(PriceController());
  static ColorController colorController = Get.put(ColorController());
  static RamController ramController = Get.put(RamController());
  static RomController romController = Get.put(RomController());

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = Get.put(TextEditingController());
    SearchController controller = Get.put(SearchController());
    ProductController productController = Get.put(ProductController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 1, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: TextField(
                autofocus: true,
                onEditingComplete: () {
                  brandController.resetBrand();
                  priceController.resetPrice();
                  colorController.resetColor();
                  ramController.resetRam();
                  romController.resetRom();
                  productController.filterProduct(brandController.brandSelected, colorController.colorSelected, priceController.priceSelected, ramController.ramSelected, romController.romSelected);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const ShowDialogLoading();
                      }
                  );
                  Future.delayed(const Duration(seconds: 3),(){
                    Get.back();
                    controller.search(searchController.value.text);
                    Get.toNamed(AppRoutes.filterProduct);
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: IconButton(
                        onPressed: (){
                          brandController.resetBrand();
                          priceController.resetPrice();
                          colorController.resetColor();
                          ramController.resetRam();
                          romController.resetRom();
                          productController.filterProduct(brandController.brandSelected, colorController.colorSelected, priceController.priceSelected, ramController.ramSelected, romController.romSelected);
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const ShowDialogLoading();
                            }
                          );
                          Future.delayed(const Duration(seconds: 3),(){
                            Get.back();
                            controller.search(searchController.value.text);
                            Get.toNamed(AppRoutes.filterProduct);
                          });
                        },
                        icon: const Icon(Icons.search)
                    ),
                  ),
                  hintText: 'Search',
                ),
              ),
            ),
          ),
        )
    );
  }
}
