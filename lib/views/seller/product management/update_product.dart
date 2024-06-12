import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/upload_file_controller.dart';

class UpdateProduct extends StatelessWidget{

  const UpdateProduct({super.key,required this.index});
  final int index;

  static ProductController controller = Get.put(ProductController());
  static UploadFileController uploadFileController = Get.put(UploadFileController());

  @override
  Widget build(BuildContext context){
    final controllerId = TextEditingController(text: controller.productList[index].id.toString());
    final controllerTen = TextEditingController(text: controller.productList[index].ten.toString());
    final controllerMoTa = TextEditingController(text: controller.productList[index].moTa.toString());
    final controllerGia = TextEditingController(text: controller.productList[index].gia.toString());
    //final controllerHinhAnh = TextEditingController(text: controller.productList[index].image.toString());
    final controllerBrand = TextEditingController(text: controller.productList[index].brand.toString());
    final controllerColor = TextEditingController(text: controller.productList[index].color.toString());
    final controllerRam = TextEditingController(text: controller.productList[index].ram.toString());
    final controllerRom = TextEditingController(text: controller.productList[index].rom.toString());
    final controllerSize = TextEditingController(text: controller.productList[index].size.toString());

    final urlImage = controller.productList[index].image.toString();

    return AlertDialog(
        title: Text("Update Dilaog"),
        content: Center(
          child: SingleChildScrollView(
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
                    maxLines: 5,
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
                    controller: controllerBrand,
                    decoration: InputDecoration(
                      label: Text("Nhãn hiệu"),
                      border: OutlineInputBorder(),
                      hintText: controller.productList[index].brand.toString(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: controllerColor,
                    decoration: InputDecoration(
                      label: Text("Màu sắc"),
                      border: OutlineInputBorder(),
                      hintText: controller.productList[index].color.toString(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: controllerRam,
                    decoration: InputDecoration(
                      label: Text("Ram"),
                      border: OutlineInputBorder(),
                      hintText: controller.productList[index].ten.toString(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: controllerRom,
                    decoration: InputDecoration(
                      label: Text("Rom"),
                      border: OutlineInputBorder(),
                      hintText: controller.productList[index].rom.toString(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: controllerSize,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Kích thước màn hình"),
                      border: OutlineInputBorder(),
                      hintText: controller.productList[index].size.toString(),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: controllerHinhAnh,
                    decoration: InputDecoration(
                      label: Text("Hình ảnh"),
                      border: OutlineInputBorder(),
                      hintText: controller.productList[index].image.toString(),
                    ),
                  ),
                ),*/
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        Obx((){
                          if(uploadFileController.pickedFile.value!=null)
                            return SizedBox(
                                height: 150,
                                width:  150,
                                child: Container(
                                  color: Colors.blue[100],
                                  child: Center(
                                    child: Image.file(
                                      File(uploadFileController.pickedFile.value!.path!),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            );
                          else{
                            return Image.network(controller.productList[index].image);
                          }
                        }),
                        SizedBox(height: 8,),
                        ElevatedButton(
                            onPressed: (){
                              uploadFileController.selectFile();
                            },
                            child: Text('Select File')
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: (){
                      controller.updateProduct(controller.productList[index].reference.id, controllerId, controllerTen, controllerGia, urlImage, controllerMoTa, controllerBrand, controllerColor, controllerRam, controllerRom, controllerSize);
                      /*Obx(() => SizedBox(
                        height: 50,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            LinearProgressIndicator(
                              value: uploadFileController.progress.value,
                              backgroundColor: Colors.grey,
                              color: Colors.green,
                            ),
                            Center(
                              child: Text(
                                '${(100* uploadFileController.progress.value).roundToDouble()}%',
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ));
                       */
                      //Get.back();
                      //Get.snackbar('Thông báo', 'Cập nhật sản phẩm thành công', duration: Duration(seconds: 3), backgroundColor: Colors.white, isDismissible: true,);
                    },
                    child: Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}