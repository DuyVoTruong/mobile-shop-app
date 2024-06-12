import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/favorite_controller.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/side_bar.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';

class FavoritePage extends StatelessWidget {

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context){

    FavoriteController favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sản phẩm yêu thích'),
      ),
      drawer: const SideBar(),
      bottomNavigationBar: const BottomBar(),
      body: Obx(() => Container(
        margin: const EdgeInsets.all(10),
            child: ListView.builder(
          itemCount: favoriteController.favoriteList.length,
          itemBuilder: (BuildContext context, int index){
            return Center(
              child: InkWell(
                onTap: (){
                  Get.to(()=>ProductDetail(product: favoriteController.favoriteList.value[index].product));
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 88,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0XFFF5F6F9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(favoriteController.favoriteList[index].product.image.toString()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  favoriteController.favoriteList[index].product.ten.toString(),
                                  style: const TextStyle(color: Colors.black, fontSize: 18),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: <Widget>[
                                    const Text("Giá: "),
                                    Text(favoriteController.favoriteList[index].product.gia.toString(), style: const TextStyle(color: Colors.red),),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                    children: <Widget>[
                                      const Text("Màu sắc: "),
                                      Flexible(child: Text(favoriteController.favoriteList[index].product.color.toString(), style: const TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                    ]
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                    children: <Widget>[
                                      const Text("Ram: "),
                                      Flexible(child: Text(favoriteController.favoriteList[index].product.ram.toString(), style: const TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                    ]
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: (){
                                    favoriteController.deleteFavorite(favoriteController.favoriteList[index].reference.id);
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  child: const Text("Hủy"),
                                ),
                                const SizedBox(height: 10,),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }

}
