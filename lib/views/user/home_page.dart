import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/favorite_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/app_bar.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/show_dialog_loading.dart';
import 'package:mobile_shop_app/views/side_bar.dart';
import 'package:mobile_shop_app/views/user/carousel/carousel.dart';
import 'package:mobile_shop_app/views/user/screen/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  //static ProductController controller = Get.put(ProductController());
  //static FavoriteController favoriteController = Get.put(FavoriteController());
  //static UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context){

    BrandController brandController = Get.put(BrandController());
    PriceController priceController = Get.put(PriceController());
    ColorController colorController = Get.put(ColorController());
    RamController ramController = Get.put(RamController());
    RomController romController = Get.put(RomController());

    FavoriteController favoriteController = Get.put(FavoriteController());
    ProductController controller = Get.put(ProductController());
    UserController userController = Get.put(UserController());
    SearchController searchController = Get.put(SearchController());
    favoriteController.GetAllByUserId(userController.user.value.id);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const AppBarShop(),
      drawer: const SideBar(),
      bottomNavigationBar: const BottomBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children: [
                const CarouselScreen(),
                //CategoryScreen(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[200]
                  ),
                  child: Row(
                    children: const [
                      Text('Top 10 sản phẩm bán chạy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Obx(() => Container(
                  margin: const EdgeInsets.all(8),
                  height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.productTop10List.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width/2.3,
                        child: ProductScreen(sanPham: controller.productTop10List[index]),
                      );
                    }
                  ),
                )),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[200]
                  ),
                  child: Row(
                    children: const [
                      Text('Top 5 sản phẩm giá rẻ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Obx(() => Container(
                  margin: const EdgeInsets.all(8),
                  height: 310,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.productTop5List.length,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                            margin: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width/2.3,
                            child: ProductScreen(sanPham: controller.productTop5List[index])
                        );
                      }
                  ),
                )),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[200]
                  ),
                  child: Row(
                    children: [
                      const Text('Các sản phẩm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const Spacer(),
                      TextButton(
                          onPressed: (){
                            brandController.resetBrand();
                            priceController.resetPrice();
                            colorController.resetColor();
                            ramController.resetRam();
                            romController.resetRom();
                            controller.filterProduct(brandController.brandSelected, colorController.colorSelected, priceController.priceSelected, ramController.ramSelected, romController.romSelected);
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const ShowDialogLoading();
                                }
                            );
                            Future.delayed(const Duration(seconds: 3),(){
                              Get.back();
                              searchController.search('');
                              Get.toNamed(AppRoutes.filterProduct);
                            });
                          },
                          child: const Text('Xem tất cả')
                      ),
                    ],
                  ),
                ),
                Obx(() => Container(
                    margin: const EdgeInsets.all(8),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 310,
                      ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.product10List.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                              margin: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width/2.3,
                              child: ProductScreen(sanPham: controller.product10List[index]),
                          );
                        }
                    ),
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
