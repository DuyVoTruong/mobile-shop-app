import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/bottom_nav_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/app_bar.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/side_bar.dart';
import 'package:mobile_shop_app/views/user/carousel/carousel.dart';
import 'package:mobile_shop_app/views/user/category/category.dart';
import 'package:mobile_shop_app/views/user/screen/product.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  static ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarShop(),
      drawer: SideBar(),
      bottomNavigationBar: BottomBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselScreen(),
              CategoryScreen(),
              Obx(() => Container(
                margin: EdgeInsets.all(10),
                child: GridView.builder(
                  shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 350,
                    ),
                    itemCount: controller.productList.length,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){Get.to(ProductDetail(product: controller.productList[index]));},
                        child: ProductScreen(sanPham: controller.productList[index])
                      );
                    }
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
