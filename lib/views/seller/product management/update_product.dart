import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/main.dart';

class UpdateProduct extends StatelessWidget{

  const UpdateProduct({super.key,required this.index});
  final int index;

  static ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context){
    final controllerId = TextEditingController(text: controller.productList[index].id.toString());
    final controllerTen = TextEditingController(text: controller.productList[index].ten.toString());
    final controllerMoTa = TextEditingController(text: controller.productList[index].moTa.toString());
    final controllerGia = TextEditingController(text: controller.productList[index].gia.toString());
    final controllerHinhAnh = TextEditingController(text: controller.productList[index].image.toString());

    return AlertDialog(
        title: Text("Update Dilaog"),
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerId,
                  decoration: InputDecoration(
                    label: Text("Id"),
                    border: OutlineInputBorder(),
                    hintText: controller.productList[index].id.toString(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerTen,
                  decoration: InputDecoration(
                    label: Text("Tên"),
                    border: OutlineInputBorder(),
                    hintText: controller.productList[index].ten.toString(),
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
                    hintText: controller.productList[index].gia.toString(),
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
                    hintText: controller.productList[index].moTa.toString(),
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
                    hintText: controller.productList[index].image.toString(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: (){
                    controller.updateProduct(controller.productList[index].reference.id, controllerId, controllerTen, controllerGia, controllerHinhAnh, controllerMoTa);
                  },
                  child: Text("Update"),
                ),
              ),
            ],
          ),
        ));
  }
}