import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/views/app_bar.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/seller/order%20management/add_order.dart';
import 'package:mobile_shop_app/views/show_dialog_message.dart';
import 'package:mobile_shop_app/views/side_bar.dart';

class CartPage extends StatelessWidget {
  static CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarShop(),
      drawer: SideBar(),
      bottomNavigationBar: BottomBar(),
      bottomSheet: Row(
        children: [
          Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tổng tiền: ${cartController.tongTien}', style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),),
          )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: (){
                  if(FirebaseAuth.instance.currentUser!=null) {
                    showDialog(
                        context: context,
                        builder: (context) => AddOrder()
                    );
                  }else{
                    showDialog(
                        context: context,
                        builder:(context)=> AlertDialog(
                          content: Text('Vui lòng đăng nhập để đặt hàng'),
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
                child: Text('Đặt hàng')
            ),
          ),
        ],
      ),
      body: Center(
        child: Obx(() => Container(
              margin: EdgeInsets.all(10),
              child: ListView.builder(
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFF5F6F9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.network(cartController
                                      .cart[index].image
                                      .toString()),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      cartController.cart[index].ten.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("Giá: "),
                                        Flexible(
                                          child: Text(
                                            cartController.cart[index].gia.toString(),
                                            style: TextStyle(color: Colors.red),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: <Widget>[
                                      Text("Mô tả: "),
                                      Flexible(
                                        child: Text(
                                          cartController.cart[index].moTa.toString(),
                                          style: TextStyle(color: Colors.red),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 10,
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: <Widget>[
                                      Text("Số lượng: "),
                                      Text(
                                        cartController.soLuong[index].toString(),
                                        style: TextStyle(color: Colors.red),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          cartController.tangSoLuong(index);
                                        },
                                        icon: Icon(Icons.add)
                                      ),
                                      IconButton(
                                          onPressed: (){
                                            cartController.giamSoLuong(index);
                                          },
                                          icon: Icon(Icons.remove)
                                      )
                                    ]),
                                  ],
                                )),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        cartController.deleteCart(index);
                                      },
                                      child: Text("Xóa"),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
