import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/side_bar.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context){

    OrderController controller = Get.put(OrderController());
    UserController userController = Get.put(UserController());

    controller.getHistoryOrderByUserId(userController.user.value.id==null?'':userController.user.value.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt hàng'),
      ),
      bottomNavigationBar: const BottomBar(),
      drawer: const SideBar(),
      body:Obx(() => Container(
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: controller.historyOrder.length,
          itemBuilder: (BuildContext context, int index){
            return Center(
              child: InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.userOrderDetail, arguments: [controller.historyOrder[index]]);
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
                                child: Image.network(controller.historyOrder[index].productList[0].image.toString()),
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
                                    controller.historyOrder[index].ngayDat.toString(),
                                    style: const TextStyle(color: Colors.black, fontSize: 18),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: <Widget>[
                                      const Text("Tổng tiền: "),
                                      Text(controller.historyOrder[index].tongTien.toString(), style: const TextStyle(color: Colors.red),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                      children: <Widget>[
                                        const Text("Địa chỉ giao: "),
                                        Flexible(child: Text(controller.historyOrder[index].diaChiGiao.toString(), style: const TextStyle(color: Colors.red), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                                      ]
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                      children: <Widget>[
                                        const Text("Trạng thái: "),
                                        controller.historyOrder[index].trangThai==0
                                            ?const Flexible(child: Text('Chưa xác nhận', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                            :controller.historyOrder[index].trangThai==1
                                            ?const Flexible(child: Text('Đã xác nhận', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                            :controller.historyOrder[index].trangThai==2
                                            ?const Flexible(child: Text('Giao cho đơn vị vận chuyển', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                            :controller.historyOrder[index].trangThai==3
                                            ?const Flexible(child: Text('Giao hàng thành công', style: TextStyle(overflow: TextOverflow.ellipsis), maxLines: 2,))
                                            :controller.historyOrder[index].trangThai==-1
                                            ?const Text('Đã hủy'):
                                            const Text(''),

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