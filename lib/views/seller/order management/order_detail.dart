import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/models/order_model.dart';

class OrderDetail extends StatelessWidget{


  const OrderDetail({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết"),
        ),
      body: Container(
        margin: EdgeInsets.all(10),
        child:
            Center(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: order.productList.length,
                    itemBuilder: (BuildContext context, int i){
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
                                      child: Image.network(order.productList[i].image.toString()),
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
                                          '',
                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: <Widget>[
                                            Text("Giá: "),
                                            Text(order.productList[i].gia.toString(), style: TextStyle(color: Colors.red),),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                            children: <Widget>[
                                              Text("Mô tả: "),
                                              Text(order.productList[i].moTa.toString(), style: TextStyle(color: Colors.red),),
                                            ]
                                        ),
                                        Row(
                                            children: <Widget>[
                                              Text("Số lượng: "),
                                              Text(order.soLuongList[i].toString(), style: TextStyle(color: Colors.red),),
                                            ]
                                        ),
                                      ],
                                    )),
                          ],
                        ),
                            SizedBox(height: 16,),
                            const Divider(),
                          ]),
                      );
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 10,),
                              Row(
                                children: <Widget>[
                                  Text("User Id: "),
                                  Text(order.userId.toString(), style: TextStyle(color: Colors.red),),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                  children: <Widget>[
                                    Text("Địa chỉ giao: "),
                                    Text(order.diaChiGiao.toString(), style: TextStyle(color: Colors.red),),
                                  ]
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                  children: <Widget>[
                                    Text("Tổng tiền: "),
                                    Text(order.tongTien.toString(), style: TextStyle(color: Colors.red),),
                                  ]
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: 16,),
                  const Divider(),
                ],
              ),
            )
      )
    );
  }
}