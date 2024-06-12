import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/upload_file_controller.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class ProductController extends GetxController{

  RxList<ProductModel> productList = RxList<ProductModel>([]);
  RxList<ProductModel> filterProductList = RxList<ProductModel>([]);
  RxList<ProductModel> productTop10List = RxList<ProductModel>([]);
  RxList<ProductModel> productTop5List = RxList<ProductModel>([]);
  RxList<ProductModel> product10List = RxList<ProductModel>([]);
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

  @override
  void onInit() {
    super.onInit();
    //productList.bindStream(getAll());
    productTop5List.bindStream(getTop5());
    productTop10List.bindStream(getTop10());
    product10List.bindStream(get10());
  }

  Stream<List<ProductModel>> getTop5(){
    Stream <QuerySnapshot> collectionStream = collectionReference.orderBy('gia', descending: false).limit(5).snapshots();
    return collectionStream.map((qShot) =>qShot.docs
        .map((doc) => ProductModel.fromSnapshot(doc)).toList());
  }

  Stream<List<ProductModel>> getTop10(){
    Stream <QuerySnapshot> collectionStream = collectionReference.orderBy('soLuongDaBan', descending: true).limit(10).snapshots();
    return collectionStream.map((qShot) =>qShot.docs
        .map((doc) => ProductModel.fromSnapshot(doc)).toList());
  }

  Stream<List<ProductModel>> get10(){
    Stream <QuerySnapshot> collectionStream = collectionReference.limit(10).snapshots();
    return collectionStream.map((qShot) =>qShot.docs
        .map((doc) => ProductModel.fromSnapshot(doc)).toList());
  }

  void GetAllProduct(){
    productList.bindStream(getAll());
  }

  Stream<List<ProductModel>> getAll(){
    Stream <QuerySnapshot> collectionStream = collectionReference.snapshots();
    return collectionStream.map((qShot) =>qShot.docs
        .map((doc) => ProductModel.fromSnapshot(doc)).toList());
  }

  Future<void> addProduct(controllerTen, controllerGia, controllerMoTa, controllerBrand, controllerColor, controllerRam, controllerRom, controllerSize) async {

    UploadFileController uploadFileController = Get.put(UploadFileController());

    try{
      await uploadFileController.uploadFile();
    }catch(e){
      print(e);
    }

    return collectionReference
        .add({
      "id": collectionReference.doc().id,
      "ten": controllerTen.text,
      "gia": int.parse(controllerGia.text),
      "image": uploadFileController.urlImage.toString(),
      "moTa": controllerMoTa.text,
      "brand": controllerBrand.text,
      "color": controllerColor.text,
      "ram": controllerRam.text,
      "rom": controllerRom.text,
      "size": double.parse(controllerSize.text),
      "soSao": 0,
      "soDanhGia": 0,
      "soLuongDaBan":0,
    })
        .then((value) {
      Get.back();
      Get.snackbar('Thông báo', 'Thêm sản phẩm thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
    })
        .catchError((error){
      Get.back();
      Get.snackbar('Thông báo', 'Thêm sản phẩm không thành công!!! Vui lòng thực hiện lại', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
    });
  }

  Future<void> deleteProduct(productId) {
    return collectionReference
        .doc(productId)
        .delete()
        .then((value) {
      Get.snackbar('Thông báo', 'Xóa sản phẩm thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
    })
        .catchError((error){
      Get.snackbar('Thông báo', 'Xóa sản phẩm không thành công!!! Vui lòng thực hiện lại', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
    });
  }

  Future<void> updateProduct(index, controllerId, controllerTen, controllerGia, urlImage, controllerMoTa, controllerBrand, controllerColor, controllerRam, controllerRom, controllerSize) async {

    UploadFileController uploadFileController = Get.put(UploadFileController());

    if(uploadFileController.pickedFile.value!=null){
      try{
        await uploadFileController.uploadFile();
      }catch(e){
        print(e);
      }

      return collectionReference
          .doc(index).update({
        "id": controllerId.text,
        "ten": controllerTen.text,
        "gia": int.parse(controllerGia.text),
        "image": uploadFileController.urlImage.toString(),
        "moTa": controllerMoTa.text,
        "brand": controllerBrand.text,
        "color": controllerColor.text,
        "ram": controllerRam.text,
        "rom": controllerRom.text,
        "size": double.parse(controllerSize.text),
      })
          .then((value) {
        Get.back();
        Get.snackbar('Thông báo', 'Cập nhật sản phẩm thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
      })
          .catchError((error){
        Get.back();
        Get.snackbar('Thông báo', 'Cập nhật sản phẩm không thành công!!! Vui lòng cập nhật lại', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
      });
    }
    else{
      return collectionReference
          .doc(index).update({
        "id": controllerId.text,
        "ten": controllerTen.text,
        "gia": int.parse(controllerGia.text),
        "image": urlImage,
        "moTa": controllerMoTa.text,
        "brand": controllerBrand.text,
        "color": controllerColor.text,
        "ram": controllerRam.text,
        "rom": controllerRom.text,
        "size": double.parse(controllerSize.text),
      })
          .then((value) {
            Get.back();
            Get.snackbar('Thông báo', 'Cập nhật sản phẩm thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
      })
          .catchError((error){
            Get.back();
            Get.snackbar('Thông báo', 'Cập nhật sản phẩm không thành công!!! Vui lòng cập nhật lại', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
      });
    }
  }

  Future<void> updateProductStar(index, soSao, product) {

      return collectionReference
          .doc(index).update({
        "soSao": (soSao+product.soSao*product.soDanhGia)/(product.soDanhGia+1),
        "soDanhGia": product.soDanhGia+1,
      })
          .then((value) => Get.back())
          .catchError((error) => print("Failed to update SoSaoSanPham: $error"));
  }

  Future<void> updateProductSold(index, product) {

    return collectionReference
        .doc(index).update({
      "soLuongDaBan": product.soLuongDaBan+1,
    })
        .then((value) => print("SoLuongDaBanSanPham Updated"))
        .catchError((error) => print("Failed to update SoLuongDaBanSanPham: $error"));
  }

  void filterProduct(brand, color, price, ram, rom){

    Query collection = FirebaseFirestore.instance.collection('SanPham');

    Stream<List<ProductModel>> getByFilter(){

      if(brand.length>0){
        collection = collection.where('brand', whereIn: brand);
      }

      switch(price.value){
        case 1:
          collection = collection.where('gia', isLessThan: 2000000);
          break;
        case 2:
          collection = collection.where('gia', isGreaterThanOrEqualTo: 2000000, isLessThanOrEqualTo: 4000000);
          break;
        case 3:
          collection = collection.where('gia', isGreaterThanOrEqualTo: 4000000, isLessThanOrEqualTo: 7000000);
          break;
        case 4:
          collection = collection.where('gia', isGreaterThanOrEqualTo: 7000000, isLessThanOrEqualTo: 13000000);
          break;
        case 5:
          collection = collection.where('gia', isGreaterThanOrEqualTo: 13000000);
          break;
        case 6:
          break;
      }

      switch (color.value){
        case 'Tất cả':
          break;
        default:
          collection = collection.where('color', isEqualTo: color.value);
      }

      switch (ram.value){
        case 'Tất cả':
          break;
        default:
          collection = collection.where('ram', isEqualTo: ram.value);
      }

      switch (rom.value){
        case 'Tất cả':
          break;
        default:
          collection = collection.where('rom', isEqualTo: rom.value);
      }

      Stream <QuerySnapshot> collectionStream = collection.snapshots();

      return collectionStream.map((qShot) =>qShot.docs
          .map((doc) => ProductModel.fromSnapshot(doc)).toList());
    }

    print('${brand}:${price}:${color}:${ram}:${rom}}');

    productList.bindStream(getByFilter());

  }
/*
  void SearchProduct(productName){
    Stream<List<ProductModel>> getSearchProduct(){
      Stream <QuerySnapshot> collectionStream = collectionReference.where('ten', isGreaterThanOrEqualTo: productName).where('ten', isLessThan: productName+'z').snapshots();
      return collectionStream.map((qShot) =>qShot.docs
          .map((doc) => ProductModel.fromSnapshot(doc)).toList());
    }
    productList.bindStream(getSearchProduct());
  }

 */

  void searchName(productName){
    filterProductList.clear();
    productList.refresh();
    for(int i=0;i<productList.length;i++){
      if(productList[i].ten.toUpperCase().contains(productName.toString().toUpperCase())==true){
        filterProductList.add(productList[i]);
      }
    }
    filterProductList.refresh();
    update();
  }

}