import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/views/user/pay_page.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';

class AddOrder extends StatefulWidget{
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrder();
}

class _AddOrder extends State<AddOrder>{


  static OrderController orderController = Get.put(OrderController());
  static UserController userController = Get.put(UserController());
  static CartController cartController = Get.put(CartController());
  String hinhThucThanhToan = 'Thanh toán bằng tiền mặt';
  var items = [
    'Thanh toán bằng tiền mặt',
    'Thanh toán online',
  ];

  final diaChiGiaoController = TextEditingController(text: userController.user.value.diaChi);
  final tenController = TextEditingController(text: userController.user.value.ten);
  final giaController = TextEditingController(text: cartController.tongTien.value.toString());
  final ngayDatController = TextEditingController(text: '${DateTime.now()}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt hàng'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10.0,),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartController.cart.length,
              itemBuilder: (BuildContext context, int i){
                return Center(
                  child: InkWell(
                    onTap: (){
                      Get.to(()=>ProductDetail(product: cartController.cart[i],));
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
                                    child: Image.network(cartController.cart[i].image.toString()),
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
                                        cartController.cart[i].ten,
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: <Widget>[
                                          const Text("Giá: "),
                                          Text(cartController.cart[i].gia.toString(), style: const TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                          children: <Widget>[
                                            const Text("Mô tả: "),
                                            Flexible(child: Text(cartController.cart[i].moTa.toString(), style: const TextStyle(color: Colors.red), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                          ]
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                          children: <Widget>[
                                            const Text("Số lượng: "),
                                            Text(cartController.soLuong[i].toString(), style: const TextStyle(color: Colors.red),),
                                          ]
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          const Divider(),
                        ]),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: diaChiGiaoController,
                decoration: const InputDecoration(
                  label: Text("Địa chỉ giao"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: giaController,
                enabled: false,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Tổng tiền"),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                enabled: false,
                controller: tenController,
                decoration: const InputDecoration(
                  label: Text("Tên người đặt"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                enabled: false,
                controller: ngayDatController,
                decoration: const InputDecoration(
                  label: Text("Ngày đặt"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: const Text('Hình thức thanh toán', style: TextStyle(fontSize: 16, color: Colors.black38),),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                  child: DropdownButton(
                    value: hinhThucThanhToan,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        hinhThucThanhToan = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: (){
                  if(hinhThucThanhToan=='Thanh toán bằng tiền mặt'){
                    orderController.addOrder(cartController.cart, cartController.soLuong, userController.user.value.id, ngayDatController, giaController, diaChiGiaoController, hinhThucThanhToan);
                  }
                  else if(hinhThucThanhToan=='Thanh toán online'){
                    Get.to(()=>const PayPage());
                  }
                },
                child: const Text('Đặt hàng'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}