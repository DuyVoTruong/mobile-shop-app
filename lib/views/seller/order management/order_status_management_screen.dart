import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/models/order_model.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class OrderStatusManagementScreen extends StatelessWidget {
  const OrderStatusManagementScreen({super.key, required this.order});

  final OrderModel order;
  static OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context){

    return Column(
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
                  child: Image.network(order.productList[0].image.toString()),
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
                      order.ngayDat.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        const Text("Tổng tiền: "),
                        Text(order.tongTien.toString(), style: const TextStyle(color: Colors.red),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                        children: <Widget>[
                          const Text("Địa chỉ giao: "),
                          Flexible(child: Text(order.diaChiGiao.toString(), style: const TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                        ]
                    ),
                    const SizedBox(height: 10,),
                    Row(
                        children: <Widget>[
                          const Text("Trạng thái: "),
                          order.trangThai==0
                              ?const Flexible(child: Text('Chưa xác nhận', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                              :order.trangThai==1
                              ?const Flexible(child: Text('Đã xác nhận', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                              :order.trangThai==2
                              ?const Flexible(child: Text('Giao cho đơn vị vận chuyển', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                              :order.trangThai==3
                              ?const Flexible(child: Text('Giao hàng thành công', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                              :order.trangThai==-1
                              ?const Flexible(child: Text('Đã hủy', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,)):const Text(''),

                          //Flexible(child: Text(controller.orderList[index].diaChiGiao.toString(), style: TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                        ]
                    ),
                  ],
                )),
          ],
        ),
        const SizedBox(height: 16,),
        const Divider(),
      ],
    );
  }

}