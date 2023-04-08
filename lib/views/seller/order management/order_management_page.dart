import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/seller/order%20management/order_detail.dart';
import 'package:mobile_shop_app/views/seller/product%20management/add_product.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class OrderManagementPage extends StatelessWidget {
  const OrderManagementPage({super.key});

  static OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý đơn hàng"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AddProduct();
                }
            );
          },
          backgroundColor: Colors.green,
          tooltip: 'Thêm sản phẩm',
          child: const Icon(Icons.add)),
      body:Obx(() => Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: controller.orderList.length,
          itemBuilder: (BuildContext context, int index){
            return Center(
              child: InkWell(
                onTap: ()=>Get.to(OrderDetail(order: controller.orderList[index])),
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
                              child: Image.network(controller.orderList[index].productList[0].image.toString()),
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
                                  controller.orderList[index].ngayDat.toString(),
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: <Widget>[
                                    Text("Tổng tiền: "),
                                    Text(controller.orderList[index].tongTien.toString(), style: TextStyle(color: Colors.red),),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                    children: <Widget>[
                                      Text("Địa chỉ giao: "),
                                      Flexible(child: Text(controller.orderList[index].diaChiGiao.toString(), style: TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                    ]
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                    children: <Widget>[
                                      Text("Trạng thái: "),
                                      controller.orderList[index].trangThai==0
                                          ?Text('Chưa xác nhận')
                                          :controller.orderList[index].trangThai==1
                                          ?Text('Đã xác nhận')
                                          :controller.orderList[index].trangThai==-1
                                          ?Text('Đã hủy'):Text(''),

                                      //Flexible(child: Text(controller.orderList[index].diaChiGiao.toString(), style: TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                    ]
                                ),
                              ],
                            )),
                        const SizedBox(width: 50,),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: (){
                                    controller.confirmOrder(controller.orderList[index].reference.id);
                                  },
                                  child: Container(margin: EdgeInsets.only(bottom: 5, top: 5),child: Text("Xác nhận giao hàng")),
                                ),
                                const SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: (){
                                    controller.cancelOrder(controller.orderList[index].reference.id);
                                  },
                                  child: Text("Hủy"),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                ),
                                const SizedBox(height: 10,),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 16,),
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