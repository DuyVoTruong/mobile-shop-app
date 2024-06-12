import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/product_controller.dart';
import 'package:mobile_shop_app/views/seller/product%20management/add_product.dart';
import 'package:mobile_shop_app/views/seller/product%20management/update_product.dart';

CollectionReference collectionReference = FirebaseFirestore.instance.collection('SanPham');

class ProductManagementPage extends StatelessWidget {
  const ProductManagementPage({super.key});

  static ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context){
    controller.GetAllProduct();
    return Scaffold(
            appBar: AppBar(
              title: const Text("Quản lý sản phẩm"),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return const AddProduct();
                      }
                  );
                },
                backgroundColor: Colors.green,
                tooltip: 'Thêm sản phẩm',
                child: const Icon(Icons.add)),
            body:Obx(() => Container(
              margin: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.productList.length,
                      itemBuilder: (BuildContext context, int index){
                        return Center(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 88,
                                    child: AspectRatio(
                                      aspectRatio: 0.88,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0XFFF5F6F9),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Image.network(controller.productList[index].image.toString()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            controller.productList[index].ten.toString(),
                                            style: const TextStyle(color: Colors.black, fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            children: <Widget>[
                                              const Text("Giá: "),
                                              Text(controller.productList[index].gia.toString(), style: const TextStyle(color: Colors.red),),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                              children: <Widget>[
                                                const Text("Mô tả: "),
                                                Flexible(
                                                    child: Text(
                                                        controller.productList[index].moTa.toString(),
                                                        style: const TextStyle(color: Colors.red),
                                                        overflow: TextOverflow.ellipsis, maxLines: 1
                                                    )
                                                ),
                                              ]
                                          ),
                                        ],
                                      )),
                                  const SizedBox(width: 50,),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ElevatedButton(
                                            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(8))),
                                            onPressed: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return UpdateProduct(index: index);
                                                  }
                                              );
                                            },
                                            child: const Text("Cập nhật"),
                                          ),
                                          const SizedBox(height: 10,),
                                          ElevatedButton(
                                            onPressed: (){
                                              controller.deleteProduct(controller.productList[index].reference.id);
                                            },
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                            child: const Text("Xóa"),
                                          ),
                                          const SizedBox(height: 10,),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(height: 16,),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30.0,),
                  ],
                ),
              ),
            )
            ),
          );
  }

}

/*
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sản phẩm"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('SanPham').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data?.docs ?? []);
      }, ); }
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 22.0),
      shrinkWrap: true,
      children: snapshot.map((data) =>
          _buildListItem(context, data)).toList(),
    ); }
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final sanPham = SanPham.fromSnapshot(data);
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0XFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(sanPham.image.toString()),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sanPham.ten.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Text("Giá: "),
                          Text(sanPham.gia.toString(), style: TextStyle(color: Colors.red),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                          children: <Widget>[
                            Text("Mô tả: "),
                            Text(sanPham.moTa.toString(), style: TextStyle(color: Colors.red),),
                          ]
                      ),
                    ],
                  )),
              const SizedBox(width: 50,),
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                final controllerId = TextEditingController(text: sanPham.id.toString());
                                final controllerTen = TextEditingController(text: sanPham.ten.toString());
                                final controllerMoTa = TextEditingController(text: sanPham.moTa.toString());
                                final controllerGia = TextEditingController(text: sanPham.gia.toString());
                                final controllerHinhAnh = TextEditingController(text: sanPham.image.toString());

                                Future<void> updateSanPham(index){
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
                                            hintText: sanPham.id.toString(),
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
                                            hintText: sanPham.ten.toString(),
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
                                            hintText: sanPham.gia.toString(),
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
                                            hintText: sanPham.moTa.toString(),
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
                                            hintText: sanPham.image.toString(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                        child: ElevatedButton(
                                          onPressed: (){
                                            updateSanPham(data.id);
                                          },
                                          child: Text("Update"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                              }
                          );
                        },
                        child: Text("Cập nhật"),
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: (){
                          print(data.id);
                          print(sanPham.reference.id);
                          deleteSanPham(sanPham.reference.id);
                        },
                        child: Text("Xóa"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}

   */