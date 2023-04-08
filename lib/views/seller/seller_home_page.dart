import 'package:flutter/material.dart';
import 'package:mobile_shop_app/views/seller/seller_app_bar.dart';

class SellerHomePage extends StatelessWidget{
  const SellerHomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: SellerAppBar(),
      body: Center(
        child: Text('Welcome to seller home'),
      ),
    );
  }
}