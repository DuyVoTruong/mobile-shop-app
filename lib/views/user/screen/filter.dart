import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/brand_controller.dart';
import 'package:mobile_shop_app/controllers/color_controller.dart';
import 'package:mobile_shop_app/controllers/price_controller.dart';
import 'package:mobile_shop_app/controllers/ram_controller.dart';
import 'package:mobile_shop_app/controllers/rom_controller.dart';
import 'package:mobile_shop_app/views/user/screen/filter/brand.dart';
import 'package:mobile_shop_app/views/user/screen/filter/color.dart';
import 'package:mobile_shop_app/views/user/screen/filter/price.dart';
import 'package:mobile_shop_app/views/user/screen/filter/ram.dart';
import 'package:mobile_shop_app/views/user/screen/filter/rom.dart';

class FilterScreen extends StatefulWidget{

  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState ()=> _FilterScreenState();

}

class _FilterScreenState extends State<FilterScreen> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context){

    TabController _tabController = TabController(length: 5,initialIndex: 0, vsync: this);

    return Column(
      children: [
        TabBar(
          labelColor: Colors.black,
          isScrollable: true,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Nhãn hiệu',
            ),
            Tab(
              text: 'Giá',
            ),
            Tab(
              text: 'Màu sắc',
            ),
            Tab(
              text: 'Ram',
            ),
            Tab(
              text: 'Dung lượng bộ nhớ',
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              Center(
                child: BrandScreen(),
              ),
              Center(
                child: PriceScreen(),
              ),
              Center(
                child: ColorScreen(),
              ),
              Center(
                child: RamScreen(),
              ),
              Center(
                child: RomScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}