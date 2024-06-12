import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/bottom_bar.dart';
import 'package:mobile_shop_app/views/side_bar.dart';
import 'package:mobile_shop_app/views/user/screen/order%20status/order_status_screen.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context){

    OrderController controller = Get.put(OrderController());
    UserController userController = Get.put(UserController());

    controller.getHistoryOrderByUserId(userController.user.value.id==null?'':userController.user.value.id);
    controller.getUnConfirmedOrder(userController.user.value.id);
    controller.getConfirmedOrder(userController.user.value.id);
    controller.getShippingOrder(userController.user.value.id);
    controller.getSuccessOrder(userController.user.value.id);
    controller.getCancelOrder(userController.user.value.id);

    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trạng thái đặt hàng'),
        ),
        bottomNavigationBar: const BottomBar(),
        drawer: const SideBar(),
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
                                Get.toNamed(AppRoutes.userOrderDetail, arguments: [controller.unConfirmedOrderList[index]]);
                              },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: OrderStatusScreen(order: controller.unConfirmedOrderList[index],)
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
                              Get.toNamed(AppRoutes.userOrderDetail, arguments: [controller.confirmedOrderList[index]]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: OrderStatusScreen(order: controller.confirmedOrderList[index],)
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
                              Get.toNamed(AppRoutes.userOrderDetail, arguments: [controller.shippingOrderList[index]]);
                            },
                            child: Container(
                              margin: const  EdgeInsets.all(8.0),
                              child: OrderStatusScreen(order: controller.shippingOrderList[index],)
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
                              Get.toNamed(AppRoutes.userOrderDetail, arguments: [controller.successOrderList[index]]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: OrderStatusScreen(order: controller.successOrderList[index],)
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
                              Get.toNamed(AppRoutes.userOrderDetail, arguments: [controller.cancelOrderList[index]]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: OrderStatusScreen(order: controller.cancelOrderList[index],)
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