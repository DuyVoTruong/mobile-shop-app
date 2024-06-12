import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/show_dialog_loading.dart';
import 'package:mobile_shop_app/views/user/screen/filter.dart';
import 'package:mobile_shop_app/views/user/screen/product.dart';

class FilterProductScreen extends StatelessWidget{
  const FilterProductScreen({super.key});

  static BrandController brandController = Get.put(BrandController());
  static PriceController priceController = Get.put(PriceController());
  static ColorController colorController = Get.put(ColorController());
  static RamController ramController = Get.put(RamController());
  static RomController romController = Get.put(RomController());

  @override
  Widget build(BuildContext context){
    ProductController productController = Get.put(ProductController());
    CartController cartController = Get.put(CartController());
    SearchController searchController = Get.put(SearchController());
    TextEditingController searchTextController = TextEditingController(text: searchController.searchText.value.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, style: BorderStyle.solid, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          height: 45,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: TextField(
              onEditingComplete: (){
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
                  searchController.search(searchTextController.value.text);
                  Get.toNamed(AppRoutes.filterProduct);
                });
              },
              controller: searchTextController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const ShowDialogLoading();
                          }
                      );
                      Future.delayed(const Duration(seconds: 3),(){
                        Get.back();
                        searchController.search(searchTextController.value.text);
                        Get.toNamed(AppRoutes.filterProduct);
                      });
                    },
                    icon: const Icon(Icons.search)
                ),
                hintText: 'Search',
              ),
            ),
          ),
        ),
        actions: <Widget>[
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
      ),
      body: Column(
            children: [
              const FilterScreen(),
              Obx(() => Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisExtent: 310,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                    shrinkWrap: true,
                    itemCount: productController.filterProductList.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width/2.3,
                          child: ProductScreen(sanPham: productController.filterProductList[index])
                      );
                    }
                  ),
                ),
              )),
            ],
          ),
    );
  }
}