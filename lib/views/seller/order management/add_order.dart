import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';

class AddOrder extends StatefulWidget{
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrder();
}

class _AddOrder extends State<AddOrder>{


  static OrderController orderController = Get.put(OrderController());
  static UserController userController = Get.put(UserController());
  static CartController cartController = Get.put(CartController());

  final diaChiGiaoController = TextEditingController();
  final tenController = TextEditingController(text: userController.userByEmail.value);
  final giaController = TextEditingController(text: cartController.tongTien.value.toString());
  final ngayDatController = TextEditingController(text: '${DateTime.now()}');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Đặt hàng'),
      content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: diaChiGiaoController,
                  decoration: InputDecoration(
                    label: Text("Địa chỉ giao"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: giaController,
                  enabled: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Tổng tiền"),
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  enabled: false,
                  controller: tenController,
                  decoration: InputDecoration(
                    label: Text("Tên người đặt"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  enabled: false,
                  controller: ngayDatController,
                  decoration: InputDecoration(
                    label: Text("Ngày đặt"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: (){
                    orderController.addOrder(cartController.cart, cartController.soLuong, userController.userId, ngayDatController, giaController, diaChiGiaoController);
                  },
                  child: Text("Đặt hàng"),
                ),
              ),
            ],
          ),
        ),
    );
  }
}