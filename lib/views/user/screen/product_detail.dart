import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/controllers/rating_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/models/product_model.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/user/screen/rating_screen.dart';

class ProductDetail extends StatelessWidget{


  const ProductDetail({super.key, required this.product});
  final ProductModel product;
  //static RatingController ratingController = Get.put(RatingController());
  //static CartController cartController = Get.put(CartController());
  //static UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context){
    RatingController ratingController = Get.put(RatingController());
    CartController cartController = Get.put(CartController());
    UserController userController = Get.put(UserController());

    ratingController.getAllByProductId(product.id);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          title: const Text("Chi tiết sản phẩm"),
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: 200,
                    child: AspectRatio(
                      aspectRatio: 0.9,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.network(product.image),
                      ),
                    )
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Flexible(
                            child: Text(product.ten, style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ), overflow: TextOverflow.ellipsis, maxLines: 2,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0,),
                      Row(
                        children: [
                          Obx(() => RatingBar.builder(
                            initialRating: ratingController.trungBinhSao(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating){},
                          )),
                          Obx(() => Text(' ${ratingController.trungBinhSao()} (${ratingController.ratingList.length})')),
                        ],
                      ),
                      const SizedBox(height: 8.0,),
                      Row(
                        children: [
                          Text('${product.gia} đ', style: const TextStyle(color: Colors.red, fontSize: 26),),
                          const SizedBox(width: 20,),
                          Text('Đã bán: ${product.soLuongDaBan}'),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Flexible(
                            child: Text('${product.moTa}', style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                            ), overflow: TextOverflow.ellipsis, maxLines: 30,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Divider(),
                      const SizedBox(height: 10,),
                      Text('Cấu hình của ${product.ten}', style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),),
                      const SizedBox(height: 10,),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1.5),
                          1: FlexColumnWidth(2)
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey.shade200),
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Giá:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${product.gia} đ"),
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Mô tả:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.moTa),
                              )
                            ]
                          ),
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey.shade200),
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Nhãn hiệu:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.brand),
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Màu sắc:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.color),
                              ),
                            ]
                          ),
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey.shade200),
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Ram:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.ram),
                              ),
                            ]
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Rom:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.rom),
                              ),
                            ]
                          ),
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey.shade200),
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Kích thước màn hình:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${product.size}"),
                              ),
                            ]
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: (){
                                  cartController.addCart(product, context);
                                },
                                child: const Icon(Icons.add_shopping_cart),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                  onPressed: (){
                                    if(userController.user.value.id==null){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                            return AlertDialog(
                                              title: const Text("Message"),
                                              content: const Text('Vui lòng đăng nhập để đánh giá'),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: Theme.of(context).textTheme.labelLarge,
                                                  ),
                                                  child: const Text('Ok'),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            );
                                          }
                                      );
                                    }
                                    else{
                                      Get.toNamed(AppRoutes.rating, arguments: [product]);
                                    }
                                  },
                                  child: const Icon(Icons.rate_review_outlined)
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          const Divider(),
                          const Text('Đánh giá sản phẩm', style: TextStyle(fontSize: 20),),
                          const SizedBox(height: 10,),
                          Obx(() => ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ratingController.ratingList.length,
                            itemBuilder: (BuildContext context, int index){
                              return RatingScreen(rating: ratingController.ratingList[index]);
                            },
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}