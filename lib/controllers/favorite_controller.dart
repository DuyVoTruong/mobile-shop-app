import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/models/favorite_model.dart';
import 'package:mobile_shop_app/models/order_model.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class FavoriteController extends GetxController{

  RxList<FavoriteModel> favoriteList = RxList<FavoriteModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('YeuThich');

  @override
  void onInit() {
    super.onInit();
  }

  void GetAllByUserId(userId){
    Stream<List<FavoriteModel>> getAllByUserId(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('userId',isEqualTo: userId).snapshots();
      return collectionStream.map((qShot) =>qShot.docs
          .map((doc) => FavoriteModel.fromSnapshot(doc)).toList());
    }
    favoriteList.bindStream(getAllByUserId());
    update();
  }

  Future<void> addFavorite(product, userId){
    return collectionReference
        .add({
      "id": collectionReference.doc().id,
      "product": {'id':product.id,'image':product.image,'gia':product.gia,'moTa':product.moTa,'ten':product.ten, 'brand':product.brand, 'color':product.color, 'ram':product.ram, 'rom':product.rom, 'size':product.size, 'soSao':product.soSao, 'soDanhGia':product.soDanhGia, 'soLuongDaBan':product.soLuongDaBan},
      "userId": userId,
    })
        .then((value) => {})
        .catchError((error) => print("Failed to add YeuThich: $error"));
  }

  Future<void> deleteFavorite(index){
    return collectionReference
        .doc(index).delete()
        .then((value) => print("Favorite delete"))
        .catchError((error) => print("Failed to delete Favorite: $error"));
  }
/*
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

 */

}