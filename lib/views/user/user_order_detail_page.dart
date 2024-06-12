import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/models/order_model.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';

class UserOrderDetailPage extends StatelessWidget{


  const UserOrderDetailPage({super.key, required this.order});

  final OrderModel order;

  static UserController userController = Get.put(UserController());
  static OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context){

    userController.getUserById(order.userId);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Chi tiết đơn hàng"),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child:
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.productList.length,
                  itemBuilder: (BuildContext context, int i){
                    return Center(
                      child: InkWell(
                        onTap: (){
                          Get.to(()=>ProductDetail(product: order.productList[i],));
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
                                        child: Image.network(order.productList[i].image.toString()),
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
                                            '${order.productList[i].ten}',
                                            style: const TextStyle(color: Colors.black, fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: <Widget>[
                                              const Text("Giá: "),
                                              Text(order.productList[i].gia.toString(), style: const TextStyle(color: Colors.red),),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                              children: <Widget>[
                                                const Text("Mô tả: "),
                                                Flexible(child: Text(order.productList[i].moTa.toString(), style: const TextStyle(color: Colors.red), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                              ]
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                              children: <Widget>[
                                                const Text("Số lượng: "),
                                                Text(order.soLuongList[i].toString(), style: const TextStyle(color: Colors.red),),
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
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                const Text("Người đặt: "),
                                Obx(() => userController.userById.value!=null
                                    ?Text(userController.userById.value.ten.toString(), style: const TextStyle(color: Colors.red),)
                                    :const Text('')
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                const Text("SĐT: "),
                                Obx(() => userController.userById.value!=null
                                    ?Text(userController.userById.value.sdt.toString(), style: const TextStyle(color: Colors.red),)
                                    :const Text('')
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                                children: <Widget>[
                                  const Text("Ngày đặt: "),
                                  Text(order.ngayDat.toString(), style: const TextStyle(color: Colors.red),),
                                ]
                            ),
                            const SizedBox(height: 10,),
                            Row(
                                children: <Widget>[
                                  const Text("Địa chỉ giao: "),
                                  Text(order.diaChiGiao.toString(), style: const TextStyle(color: Colors.red),),
                                ]
                            ),
                            const SizedBox(height: 10,),
                            Row(
                                children: <Widget>[
                                  const Text("Hình thức thanh toán: "),
                                  Flexible(
                                      child: Text(
                                          order.hinhThucThanhToan.toString(),
                                          style: const TextStyle(color: Colors.red),
                                          overflow: TextOverflow.ellipsis, maxLines: 1
                                      )
                                  ),
                                ]
                            ),
                            const SizedBox(height: 10,),
                            Row(
                                children: <Widget>[
                                  const Text("Tổng tiền: "),
                                  Text(order.tongTien.toString(), style: const TextStyle(color: Colors.red),),
                                ]
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 16,),
                const Divider(),
                const SizedBox(height: 10,),
                order.trangThai==0
                    ?Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: (){
                          orderController.cancelOrder(order.reference.id);
                          Get.back();
                        },
                        child: const Text('Hủy đơn hàng'),
                      ),
                    )
                    :order.trangThai==1
                    ?Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: (){
                          orderController.cancelOrder(order.reference.id);
                          Get.back();
                        },
                        child: const Text('Hủy đơn hàng'),
                      ),
                    )
                    :const Text('')
              ],
            ),
          ),
        )
    );
  }
}