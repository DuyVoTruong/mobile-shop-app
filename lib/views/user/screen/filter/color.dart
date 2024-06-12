import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/search_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/show_dialog_loading.dart';

class ColorScreen extends StatelessWidget {

  const ColorScreen({super.key});

  static ColorController colorController = Get.put(ColorController());
  static SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 50,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: colorController.color.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: (){
                  colorController.selectColor(index);
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: colorController.color[index].isCheck == false
                        ? Border.all(
                        color: Colors.black45,
                        style: BorderStyle.solid,
                        width: 1.0)
                        : Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    child: Text(colorController.color[index].color),
                  ),
                ));
          }),
    ));
  }
}
