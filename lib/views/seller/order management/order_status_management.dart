import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/seller/order%20management/order_status_management_screen.dart';
import 'package:mobile_shop_app/views/side_bar.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class OrderStatusManagement extends StatelessWidget {
  const OrderStatusManagement({super.key});

  @override
  Widget build(BuildContext context){

    OrderController controller = Get.put(OrderController());
    controller.getAllOrder();
    controller.getCancelAllOrder();
    controller.getUnConfirmedAllOrder();
    controller.getSuccessAllOrder();
    controller.getShippingAllOrder();
    controller.getConfirmedAllOrder();

    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Trạng thái đơn hàng'),
          ),
          body: Column(
            children: [
              const TabBar(
                labelColor: Colors.black,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    text: 'Chưa xác nhận',
                  ),
                  Tab(
                    text: 'Đã xác nhận',
                  ),
                  Tab(
                    text: 'Giao cho đơn vị vận chuyển',
                  ),
                  Tab(
                    text: 'Giao hàng thành công',
                  ),
                  Tab(
                    text: 'Đã hủy',
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    children: <Widget>[
                      Center(
                        child: Obx(() => ListView.builder(
                          itemCount: controller.unConfirmedOrderList.length,
                          itemBuilder: (BuildContext context, int index){
                            return InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoutes.orderDetail, arguments: [controller.unConfirmedOrderList[index]]);
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: OrderStatusManagementScreen(order: controller.unConfirmedOrderList[index],)
                                )
                            );
                          },
                        )),
                      ),
                      Center(
                        child: Obx(() => ListView.builder(
                          itemCount: controller.confirmedOrderList.length,
                          itemBuilder: (BuildContext context, int index){
                            return InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoutes.orderDetail, arguments: [controller.confirmedOrderList[index]]);
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: OrderStatusManagementScreen(order: controller.confirmedOrderList[index],)
                                )
                            );
                          },
                        )),
                      ),
                      Center(
                        child: Obx(() => ListView.builder(
                          itemCount: controller.shippingOrderList.length,
                          itemBuilder: (BuildContext context, int index){
                            return InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoutes.orderDetail, arguments: [controller.shippingOrderList[index]]);
                                },
                                child: Container(
                                    margin: const  EdgeInsets.all(8.0),
                                    child: OrderStatusManagementScreen(order: controller.shippingOrderList[index],)
                                )
                            );
                          },
                        )),
                      ),
                      Center(
                        child: Obx(() => ListView.builder(
                          itemCount: controller.successOrderList.length,
                          itemBuilder: (BuildContext context, int index){
                            return InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoutes.orderDetail, arguments: [controller.successOrderList[index]]);
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: OrderStatusManagementScreen(order: controller.successOrderList[index],)
                                )
                            );
                          },
                        )),
                      ),
                      Center(
                        child: Obx(() => ListView.builder(
                          itemCount: controller.cancelOrderList.length,
                          itemBuilder: (BuildContext context, int index){
                            return InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoutes.orderDetail, arguments: [controller.cancelOrderList[index]]);
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: OrderStatusManagementScreen(order: controller.cancelOrderList[index],)
                                )
                            );
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

}