import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/rating_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  //static ProductModel product = Get.arguments[0];
  //static UserController userController = Get.put(UserController());
  //static RatingController ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.arguments[0];
    UserController userController = Get.put(UserController());
    RatingController ratingController = Get.put(RatingController());

    final noiDungController = TextEditingController();
    var soSao = 0.0;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Đánh giá sản phẩm'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  soSao = rating;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: noiDungController,
                  decoration: const InputDecoration(
                    label: Text("Nội dung"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    if(soSao==0){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text("Message"),
                              content: const Text('Vui lòng chọn số sao'),
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
                      //print(product);
                      ratingController.addRating(product, userController.user.value.id, userController.user.value.ten, noiDungController, soSao, context);
                    }
                  },
                  child: const Text('Thêm đánh giá')
              ),
            ],
          ),
        ));
  }
}
