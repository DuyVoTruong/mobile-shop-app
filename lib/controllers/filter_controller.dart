import 'package:get/get.dart';

class FilterController extends GetxController{

  var color = [
    {'mau': 'Trắng', 'isCheck': false},
    {'mau': 'Đen', 'isCheck': false},
    {'mau': 'Xanh', 'isCheck': false},
    {'mau': 'Xanh lá', 'isCheck': false},
    {'mau': 'Vàng', 'isCheck': false},
  ];

  RxList brand = RxList([
    {'link': 'https://cdn.tgdd.vn/Brand/1/logo-iphone-220x48.png', 'brand': 'Iphone', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/samsungnew-220x48-1.png', 'brand': 'Samsung', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/OPPO42-b_5.jpg', 'brand': 'Oppo', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/logo-xiaomi-220x48-5.png', 'brand': 'Xiaomi', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/vivo-logo-220-220x48-3.png', 'brand': 'Vivo', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/Realme42-b_37.png', 'brand': 'Realme', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/Nokia42-b_21.jpg', 'brand': 'Nokia', 'isCheck': false},
    {'link': 'https://cdn.tgdd.vn/Brand/1/Mobell42-b_19.jpg', 'brand': 'Mobell', 'isCheck': false},
  ]);

  var size = [
    {'size': '5.5 inch', 'isCheck': false},
    {'size': '6.0 inch', 'isCheck': false},
    {'size': '6.3 inch', 'isCheck': false},
    {'size': '6.5 inch', 'isCheck': false},
    {'size': '6.7 inch', 'isCheck': false},
  ];

  var price = [
    {'title': 'Dưới 2 triệu', 'value': 1, 'isCheck': false},
    {'title': 'Từ 2 triệu đến 5 triệu', 'value': 2, 'isCheck': false},
    {'title': 'Từ 5 triệu đến 10 triệu', 'value': 3, 'isCheck': false},
    {'title': 'Dưới 10 triệu', 'value': 4, 'isCheck': false},
    {'title': 'Trên 10 triệu', 'value': 5, 'isCheck': false},
  ];

  var ram = [
    {'ram': '2G', 'isCheck': false},
    {'ram': '3G', 'isCheck': false},
    {'ram': '4G', 'isCheck': false},
    {'ram': '6G', 'isCheck': false},
    {'ram': '8G', 'isCheck': false},
    {'ram': '12G', 'isCheck': false},
  ];

  var boNho = [
    {'value': '16G', 'isCheck': false},
    {'value': '32G', 'isCheck': false},
    {'value': '64G', 'isCheck': false},
    {'value': '128G', 'isCheck': false},
    {'value': '256G', 'isCheck': false},
    {'value': '512G', 'isCheck': false},
    {'value': '1TB', 'isCheck': false},
  ];

  RxList brandSelected = RxList([]);
  RxList colorSelected = RxList([]);
  RxList sizeSelected = RxList([]);
  RxList priceSelected = RxList([]);
  RxList ramSelected = RxList([]);
  RxList boNhoSelected = RxList([]);

  void selectBrand(index){
    brand.value[index]['isCheck']=!brand.value[index]['isCheck'];
    if(brand.value[index]['isCheck']==true){
      brandSelected.add(brand.value[index]['brand']);
    } else {
      brandSelected.remove(brand.value[index]['isCheck']);
    }
    update();
  }

}