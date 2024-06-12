import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/controllers/upload_file_controller.dart';

class AddProduct extends StatefulWidget{
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct>{
  
  static ProductController controller = Get.put(ProductController());
  static UploadFileController uploadFileController = Get.put(UploadFileController());
  
  final controllerTen = TextEditingController();
  final controllerMoTa = TextEditingController();
  final controllerGia = TextEditingController();
  //final controllerHinhAnh = TextEditingController();
  final controllerBrand = TextEditingController();
  final controllerColor = TextEditingController();
  final controllerRam = TextEditingController();
  final controllerRom = TextEditingController();
  final controllerSize = TextEditingController();
  //var urlImage;

  /*
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
    urlImage = urlDownload.toString();
    setState(() {
      uploadTask = null;
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }*/

  CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm sản phẩm"),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerTen,
                  decoration: const InputDecoration(
                    label: Text("Tên"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerGia,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Giá"),
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerMoTa,
                  decoration: const InputDecoration(
                    label: Text("Mô tả"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerBrand,
                  decoration: const InputDecoration(
                    label: Text("Nhãn hiệu"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerColor,
                  decoration: const InputDecoration(
                    label: Text("Màu sắc"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerRam,
                  decoration: const InputDecoration(
                    label: Text("Ram"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerRom,
                  decoration: const InputDecoration(
                    label: Text("Rom"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerSize,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Kích thước màn hình"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: TextField(
                  controller: controllerHinhAnh,
                  decoration: InputDecoration(
                    label: Text("Hình ảnh"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Obx((){
                      if(uploadFileController.pickedFile.value!=null){
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
                      }
                      return const Text('');
                    }),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                        onPressed: (){
                          uploadFileController.selectFile();
                        },
                        child: const Text('Select File')
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: (){
                    controller.addProduct(controllerTen, controllerGia, controllerMoTa, controllerBrand, controllerColor, controllerRam, controllerRom, controllerSize);
                    uploadFileController.urlImage.value="";
                    //Get.back();
                    //Get.snackbar('Thông báo', 'Thêm sản phẩm thành công', duration: Duration(seconds: 3), backgroundColor: Colors.white, isDismissible: true,);
                  },
                  child: const Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget buildProgress()=>StreamBuilder<TaskSnapshot>(
    stream: uploadFileController.uploadTask?.value.snapshotEvents,
    builder: (context, snapshot){
      if (snapshot.hasData){
        final data = snapshot.data!;
        double progress = data.bytesTransferred/ data.totalBytes;
        return SizedBox(
          height: 50,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
              Center(
                child: Text(
                  '${(100* progress).roundToDouble()}%',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      } else {
        return const SizedBox(height: 50,);
      }
    },
  );*/

}