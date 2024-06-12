import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/models/rating_model.dart';

class RatingController extends GetxController{

  RxList<RatingModel> ratingList = RxList<RatingModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('DanhGia');
  static ProductController productController = Get.put(ProductController());

  @override
  void onInit() {
    super.onInit();
  }

  void getAllByProductId(productId){
    Stream<List<RatingModel>> getByProductId(productId){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('productId', isEqualTo: productId).snapshots();
      return collectionStream.map((qShot) =>qShot.docs
          .map((doc) => RatingModel.fromSnapshot(doc)).toList());
    }
    ratingList.bindStream(getByProductId(productId));
    update();
  }

  double trungBinhSao(){
    print(ratingList);
    double tong=0;
    for(int i=0;i<ratingList.length;i++){
      tong=tong+ratingList[i].soSao;
    }
    if(ratingList.length==0){
      return 0;
    }
    return tong/ratingList.length;
  }

  Future<void> addRating(product, userId, ten, noiDungController, soSao, context){

    productController.updateProductStar(product.reference.id, soSao, product);

    return collectionReference
        .add({
      "id": collectionReference.doc().id,
      "productId": product.id,
      "userId": userId,
      "ten": ten,
      "soSao": soSao,
      "noiDung": noiDungController.text,
      "ngay": Timestamp.now(),
    })
        .then((value) => {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thêm đánh giá thành công"), duration: Duration(seconds: 2),behavior: SnackBarBehavior.floating, backgroundColor: Colors.blue,))
          //print("DanhGia Added");
        })
        .catchError((error) => print("Failed to add DanhGia: $error"));
  }

  Future<void> deleteProduct(productId) {
    return collectionReference
        .doc(productId)
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