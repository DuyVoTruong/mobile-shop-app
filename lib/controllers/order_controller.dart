import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/models/order_model.dart';

class OrderController extends GetxController{

  RxList<OrderModel> orderList = RxList<OrderModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('DonHang');

  @override
  void onInit() {
    super.onInit();
    orderList.bindStream(getAll());
  }

  Stream<List<OrderModel>> getAll(){
    Stream <QuerySnapshot> collectionStream = collectionReference.snapshots();
    return collectionStream.map((qShot) =>qShot.docs
        .map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }

  Future<void> addOrder(productList, soLuongList, userId, ngayDat, tongTien, diaChiGiao){
    return collectionReference
        .add({
      "id": collectionReference.doc().id,
      "productList": productList.map((p)=>{'id':p.id,'image':p.image,'gia':p.gia,'moTa':p.moTa,'ten':p.ten}).toList(),
      "soLuongList": soLuongList,
      "userId": userId.value,
      "ngayDat": Timestamp.now(),
      "tongTien": tongTien.text,
      "diaChiGiao": diaChiGiao.text,
      "trangThai": 0,
    })
        .then((value) => {print("DonHang Added")})
        .catchError((error) => print("Failed to add DonHang: $error"));
  }

  Future<void> confirmOrder(index){
    return collectionReference
        .doc(index).update({
      "trangThai": 1,
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

  Future<void> deleteProduct(index) {
    return collectionReference
        .doc(index)
        .delete()
        .then((value) => print("DonHang Deleted"))
        .catchError((error) => print("Failed to delete DonHang: $error"));
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

}