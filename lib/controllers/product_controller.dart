import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class ProductController extends GetxController{

  RxList<ProductModel> productList = RxList<ProductModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

  @override
  void onInit() {
    super.onInit();
    productList.bindStream(getAll());
  }

  Stream<List<ProductModel>> getAll(){
    Stream <QuerySnapshot> collectionStream = collectionReference.snapshots();
    return collectionStream.map((qShot) =>qShot.docs
        .map((doc) => ProductModel.fromSnapshot(doc)).toList());
  }

  Future<void> addProduct(controllerTen, controllerGia, controllerHinhAnh, controllerMoTa){
    return collectionReference
        .add({
      "id": collectionReference.doc().id,
      "ten": controllerTen.text,
      "gia": int.parse(controllerGia.text),
      "image": controllerHinhAnh.text,
      "moTa": controllerMoTa.text,
    })
        .then((value) => print("SanPham Added"))
        .catchError((error) => print("Failed to add SanPham: $error"));
  }

  Future<void> deleteProduct(index) {
    return collectionReference
        .doc(index)
        .delete()
        .then((value) => print("SanPham Deleted"))
        .catchError((error) => print("Failed to delete SanPham: $error"));
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
        .then((value) => print("SanPham Updated"))
        .catchError((error) => print("Failed to update SanPham: $error"));
  }

}