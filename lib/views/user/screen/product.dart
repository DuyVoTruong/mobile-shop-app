import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/favorite_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/models/product_model.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';

class ProductScreen extends StatelessWidget {

  const ProductScreen({super.key, required this.sanPham});
  final ProductModel sanPham;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    FavoriteController favoriteController = Get.put(FavoriteController());

    return Card(
          margin: const EdgeInsets.only(
            top: 0,
            bottom: 0,
          ),
          elevation: 6.0,
          shadowColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: (){Get.to(()=>ProductDetail(product: sanPham));},
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(sanPham.image),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${sanPham.ten}',
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              overflow: TextOverflow.ellipsis, maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: sanPham.soSao,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemSize: 16.0,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating){},
                                ),
                                const Spacer(),
                                Obx((){
                                  if(favoriteController.favoriteList.length>0){
                                    for(int i=0;i<favoriteController.favoriteList.length;i++){
                                      if(favoriteController.favoriteList[i].product.id==sanPham.id){
                                        return InkWell(
                                          onTap: (){
                                            favoriteController.deleteFavorite(favoriteController.favoriteList[i].reference.id);
                                          },
                                          child: const Icon(Icons.favorite, color: Colors.red,),
                                        );
                                      }
                                    }
                                  }
                                  return InkWell(
                                    onTap: (){
                                      favoriteController.addFavorite(sanPham, userController.user.value.id);
                                    },
                                    child: const Icon(Icons.favorite_border)
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('${sanPham.gia} đ', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
