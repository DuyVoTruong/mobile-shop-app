import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/show_dialog_loading.dart';

class BrandScreen extends StatelessWidget {

  const BrandScreen({super.key});

  static BrandController brandController = Get.put(BrandController());
  static SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 40,
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: brandController.brand.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                brandController.selectBrand(index);
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const ShowDialogLoading();
                    }
                );
                Future.delayed(const Duration(seconds: 3),(){
                  Get.back();
                  searchController.search(searchController.searchText.value);
                  Get.toNamed(AppRoutes.filterProduct);
                });
              },
              child: Container(
                    decoration: BoxDecoration(
                      border: brandController.brand[index].isCheck == false
                          ? Border.all(
                              color: Colors.black45,
                              style: BorderStyle.solid,
                              width: 1.0)
                          : Border.all(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Container(
                        margin: const EdgeInsets.all(2),
                        child: Image.network(
                            brandController.brand[index].link,
                            fit: BoxFit.fitWidth)),
                  ),
            );
          }),
    ));
  }
}
