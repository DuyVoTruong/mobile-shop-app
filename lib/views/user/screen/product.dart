import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/cart_controller.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class ProductScreen extends StatelessWidget {

  const ProductScreen({super.key, required this.sanPham});
  final ProductModel sanPham;
  static CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Card(
          margin: EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
          ),
          elevation: 6.0,
          shadowColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(sanPham.image),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${sanPham.ten}',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            overflow: TextOverflow.ellipsis, maxLines: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Giá: ${sanPham.gia}', overflow: TextOverflow.ellipsis,),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Mô tả: ${sanPham.moTa}', overflow: TextOverflow.ellipsis, maxLines: 2,),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: (){
                                cartController.addCart(sanPham);
                              },
                              child: Text('Thêm vào giỏ hàng')
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
