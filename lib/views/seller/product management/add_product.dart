import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';

class AddProduct extends StatefulWidget{
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct>{
  
  static ProductController controller = Get.put(ProductController());
  
  final controllerTen = TextEditingController();
  final controllerMoTa = TextEditingController();
  final controllerGia = TextEditingController();
  final controllerHinhAnh = TextEditingController();

  CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm sản phẩm"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: controllerTen,
                decoration: InputDecoration(
                  label: Text("Tên"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: controllerGia,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Giá"),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: controllerMoTa,
                decoration: InputDecoration(
                  label: Text("Mô tả"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: controllerHinhAnh,
                decoration: InputDecoration(
                  label: Text("Hình ảnh"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: (){(controller.addProduct(controllerTen, controllerGia, controllerHinhAnh, controllerMoTa));},
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}