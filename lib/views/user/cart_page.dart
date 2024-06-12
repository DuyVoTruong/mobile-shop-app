import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  //static CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      bottomSheet: Row(
        children: [
          Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tổng tiền: ${cartController.tongTien}', style: const TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),),
          )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: (){
                  if(FirebaseAuth.instance.currentUser!=null) {
                    if(cartController.cart.isEmpty==true){
                      showDialog(
                          context: context,
                          builder:(context)=> AlertDialog(
                            content: const Text('Vui lòng thêm sản phẩm vào giỏ để đặt hàng'),
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
                          )
                      );
                    }else{
                      Get.toNamed(AppRoutes.addOrder);
                    }
                  }else{
                    showDialog(
                        context: context,
                        builder:(context)=> AlertDialog(
                          content: const Text('Vui lòng đăng nhập để đặt hàng'),
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
                        )
                    );
                  }
                },
                child: const Text('Đặt hàng')
            ),
          ),
        ],
      ),
      body: Obx(() => Container(
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartController.soLuong.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
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
                                      child: Image.network(cartController
                                          .cart[index].image
                                          .toString()),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          cartController.cart[index].ten.toString(),
                                          style: const TextStyle(color: Colors.black, fontSize: 18),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text("Giá: "),
                                            Flexible(
                                              child: Text(
                                                cartController.cart[index].gia.toString(),
                                                style: const TextStyle(color: Colors.red),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: <Widget>[
                                          const Text("Mô tả: "),
                                          Flexible(
                                            child: Text(
                                              cartController.cart[index].moTa.toString(),
                                              style: const TextStyle(color: Colors.red),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: <Widget>[
                                          const Text("Số lượng: "),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black54, width: 2),
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    cartController.tangSoLuong(index);
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 28,
                                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                                    child: const Icon(Icons.add, size: 16,),
                                                  ),
                                                ),
                                                Container(color: Colors.black45, height: 28, width: 2,),
                                                Container(
                                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                                  child: Text(
                                                    cartController.soLuong[index].toString(),
                                                    style: const TextStyle(color: Colors.red),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(color: Colors.black45, height: 28, width: 2,),
                                                InkWell(
                                                  onTap: (){
                                                    cartController.giamSoLuong(index);
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 28,
                                                    margin: const EdgeInsets.only(left: 5, right: 5),
                                                    child: const Icon(Icons.remove, size: 16,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            cartController.deleteCart(index);
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          child: const Text("Xóa"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          )),
    );
  }
}
