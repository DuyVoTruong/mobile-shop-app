import 'package:flutter/material.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class ProductDetail extends StatelessWidget{


  const ProductDetail({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: 0.9,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.network(product.image),
                    ),
                  )
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(35), topLeft: Radius.circular(35)),
                    color: Color.fromRGBO(224, 255, 255, 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text('${product.ten}', style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Giá: ${product.gia}"),
                              Text(""),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Text("Mô tả: ${product.moTa}"),
                              Text(""),
                            ],
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}