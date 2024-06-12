import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class OrderManagementPage extends StatelessWidget {
  const OrderManagementPage({super.key});

  static OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context){
    controller.getAllOrder();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
      ),
      body:Obx(() => Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: controller.orderList.length,
          itemBuilder: (BuildContext context, int index){
            return Center(
              child: InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.orderDetail, arguments: [controller.orderList[index]]);
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
                              child: Image.network(controller.orderList[index].productList[0].image.toString()),
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
                                  controller.orderList[index].ngayDat.toString(),
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: <Widget>[
                                    const Text("Tổng tiền: "),
                                    Text(controller.orderList[index].tongTien.toString(), style: const TextStyle(color: Colors.red),),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                    children: <Widget>[
                                      const Text("Địa chỉ giao: "),
                                      Flexible(child: Text(controller.orderList[index].diaChiGiao.toString(), style: const TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                    ]
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                    children: <Widget>[
                                      const Text("Trạng thái: "),
                                      controller.orderList[index].trangThai==0
                                          ?const Flexible(child: Text('Chưa xác nhận', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                          :controller.orderList[index].trangThai==1
                                          ?const Flexible(child: Text('Đã xác nhận', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                          :controller.orderList[index].trangThai==2
                                          ?const Flexible(child: Text('Giao cho đơn vị vận chuyển', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 3,))
                                          :controller.orderList[index].trangThai==3
                                          ?const Flexible(child: Text('Giao hàng thành công', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                          :controller.orderList[index].trangThai==-1
                                          ?const Flexible(child: Text('Đã hủy', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,)):const Text(''),

                                      //Flexible(child: Text(controller.orderList[index].diaChiGiao.toString(), style: TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
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
                                    controller.confirmOrder(controller.orderList[index].reference.id);
                                  },
                                  child: Container(margin: const EdgeInsets.only(bottom: 5, top: 5),child: const Text("Xác nhận giao hàng")),
                                ),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: (){
                                    controller.cancelOrder(controller.orderList[index].reference.id);
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
      )
      ),
    );
  }

}