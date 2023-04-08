import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {

  var category = [
    'https://cdn.tgdd.vn/Brand/1/logo-iphone-220x48.png',
    'https://cdn.tgdd.vn/Brand/1/samsungnew-220x48-1.png',
    'https://cdn.tgdd.vn/Brand/1/OPPO42-b_5.jpg',
    'https://cdn.tgdd.vn/Brand/1/logo-xiaomi-220x48-5.png',
    'https://cdn.tgdd.vn/Brand/1/vivo-logo-220-220x48-3.png',
    'https://cdn.tgdd.vn/Brand/1/Realme42-b_37.png',
    'https://cdn.tgdd.vn/Brand/1/Nokia42-b_21.jpg',
    'https://cdn.tgdd.vn/Brand/1/Mobell42-b_19.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 40,
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, style: BorderStyle.solid, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Container(margin: EdgeInsets.all(2), child: Image.network(category[index], fit: BoxFit.fitWidth)),
            );
          }
      ),
    );
  }
}
