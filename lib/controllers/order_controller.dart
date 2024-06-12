import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/models/order_model.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class OrderController extends GetxController{

  RxList<OrderModel> orderList = RxList<OrderModel>([]);
  RxList<OrderModel> historyOrder = RxList<OrderModel>([]);
  RxList<OrderModel> unConfirmedOrderList = RxList<OrderModel>([]);
  RxList<OrderModel> confirmedOrderList = RxList<OrderModel>([]);
  RxList<OrderModel> shippingOrderList = RxList<OrderModel>([]);
  RxList<OrderModel> successOrderList = RxList<OrderModel>([]);
  RxList<OrderModel> cancelOrderList = RxList<OrderModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('DonHang');

  @override
  void onInit() {
    super.onInit();
    //orderList.bindStream(getAll());
  }

  void getAllOrder(){
    Stream<List<OrderModel>> getAll(){
      Stream <QuerySnapshot> collectionStream = collectionReference.snapshots();
      return collectionStream.map((qShot) =>qShot.docs
          .map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }
    orderList.bindStream(getAll());
    update();
  }

  Future<void> addOrder(productList, soLuongList, userId, ngayDat, tongTien, diaChiGiao, hinhThucThanhToan){

    ProductController productController = Get.put(ProductController());

    for(int i=0;i<productList.length;i++){
      productController.updateProductSold(productList[i].reference.id, productList[i]);
    }

    return collectionReference
        .add({
      "id": collectionReference.doc().id,
      "productList": productList.map((p)=>{'id':p.id,'image':p.image,'gia':p.gia,'moTa':p.moTa,'ten':p.ten, 'brand':p.brand, 'color':p.color, 'ram':p.ram, 'rom':p.rom, 'size':p.size, 'soSao': p.soSao, 'soDanhGia': p.soDanhGia, 'soLuongDaBan': p.soLuongDaBan}).toList(),
      "soLuongList": soLuongList,
      "userId": userId,
      "ngayDat": Timestamp.now(),
      "tongTien": tongTien.text,
      "diaChiGiao": diaChiGiao.text,
      "trangThai": 0,
      "hinhThucThanhToan": hinhThucThanhToan,
    })
        .then((value){
          Get.offNamed(AppRoutes.home);
          Get.snackbar('Thông báo', 'Đặt hàng thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
        })
        .catchError((error) {
          Get.snackbar('Thông báo', 'Đặt hàng không thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true,);
        });
  }

  Future<void> confirmOrder(index){
    return collectionReference
        .doc(index).update({
      "trangThai": 1,
    })
        .then((value) => print("DonHang Updated"))
        .catchError((error) => print("Failed to update DonHang: $error"));
  }

  Future<void> shippingOrder(index){
    return collectionReference
        .doc(index).update({
      "trangThai": 2,
    })
        .then((value) => print("DonHang Updated"))
        .catchError((error) => print("Failed to update DonHang: $error"));
  }

  Future<void> successOrder(index){
    return collectionReference
        .doc(index).update({
      "trangThai": 3,
    })
        .then((value) => print("DonHang Updated"))
        .catchError((error) => print("Failed to update DonHang: $error"));
  }

  Future<void> cancelOrder(index){
    return collectionReference
        .doc(index).update({
      "trangThai": -1,
    })
        .then((value) => print("DonHang Updated"))
        .catchError((error) => print("Failed to update DonHang: $error"));
  }

  Future<void> deleteOrder(orderId) {
    return collectionReference
        .doc(orderId)
        .delete()
        .then((value) => print("DonHang Deleted"))
        .catchError((error) => print("Failed to delete DonHang: $error"));
  }
  
  void getUnConfirmedOrder(userId){
    Stream<List<OrderModel>>unConfirmedOrderByUserId(userId){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('userId', isEqualTo: userId).where('trangThai', isEqualTo: 0).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    unConfirmedOrderList.bindStream(unConfirmedOrderByUserId(userId));
  }

  void getConfirmedOrder(userId){
    Stream<List<OrderModel>>confirmedOrderByUserId(userId){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('userId', isEqualTo: userId).where('trangThai', isEqualTo: 1).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    confirmedOrderList.bindStream(confirmedOrderByUserId(userId));
  }

  void getShippingOrder(userId){
    Stream<List<OrderModel>>shippingOrderByUserId(userId){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('userId', isEqualTo: userId).where('trangThai', isEqualTo: 2).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    shippingOrderList.bindStream(shippingOrderByUserId(userId));
  }

  void getSuccessOrder(userId){
    Stream<List<OrderModel>>successOrderByUserId(userId){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('userId', isEqualTo: userId).where('trangThai', isEqualTo: 3).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    successOrderList.bindStream(successOrderByUserId(userId));
  }

  void getCancelOrder(userId){
    Stream<List<OrderModel>>unConfirmedOrderByUserId(userId){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('userId', isEqualTo: userId).where('trangThai', isEqualTo: -1).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    cancelOrderList.bindStream(unConfirmedOrderByUserId(userId));
  }

  void getUnConfirmedAllOrder(){
    Stream<List<OrderModel>>unConfirmedOrder(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('trangThai', isEqualTo: 0).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    unConfirmedOrderList.bindStream(unConfirmedOrder());
  }

  void getConfirmedAllOrder(){
    Stream<List<OrderModel>>confirmedOrder(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('trangThai', isEqualTo: 1).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    confirmedOrderList.bindStream(confirmedOrder());
  }

  void getShippingAllOrder(){
    Stream<List<OrderModel>>shippingOrder(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('trangThai', isEqualTo: 2).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    shippingOrderList.bindStream(shippingOrder());
  }

  void getSuccessAllOrder(){
    Stream<List<OrderModel>>successOrder(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('trangThai', isEqualTo: 3).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    successOrderList.bindStream(successOrder());
  }

  void getCancelAllOrder(){
    Stream<List<OrderModel>>unConfirmedOrder(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('trangThai', isEqualTo: -1).snapshots();
      return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
    }

    cancelOrderList.bindStream(unConfirmedOrder());
  }

  Future<void> updateProduct(index, controllerId, controllerTen, controllerGia, controllerHinhAnh, controllerMoTa){
    return collectionReference
        .doc(index).update({
      "id": controllerId.text,
      "ten": controllerTen.text,
      "gia": int.parse(controllerGia.text),
      "image": controllerHinhAnh.text,
      "moTa": controllerMoTa.text,
    })
        .then((value) => print("DonHang Updated"))
        .catchError((error) => print("Failed to update DonHang: $error"));
  }

  Stream<List<OrderModel>>getOrderByUserId(userId){
    Stream <QuerySnapshot> collectionStream = collectionReference.where('userId', isEqualTo: userId).snapshots();
    return collectionStream.map((qShot) => qShot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }

  void getHistoryOrderByUserId(userId){
    historyOrder.bindStream(getOrderByUserId(userId));
    update();
  }

}