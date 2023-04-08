import 'package:get/get.dart';
import 'package:mobile_shop_app/models/product_model.dart';

class CartController extends GetxController{
  RxList<ProductModel> cart = RxList<ProductModel>([]);
  RxList<int> soLuong = RxList<int>([]);
  Rx<int> tongTien = Rx<int>(0);

  void addCart(product){
    var temp;
    for(int i=0;i<cart.length;i++){
      if(cart[i].id==product.id){
        temp=i;
      }
    }
    if(temp==null){
      cart.add(product);
      soLuong.add(1);
    }else{
      soLuong[temp]++;
    }
    tongTien.value=tongTien.value+int.parse(product.gia.toString());
    update();
  }

  void deleteCart(index){
    tongTien.value=tongTien.value-cart[index].gia*soLuong[index];
    cart.removeAt(index);
    soLuong.removeAt(index);
    update();
  }

  void tangSoLuong(index){
    soLuong[index]++;
    tongTien.value=tongTien.value+cart[index].gia;
    update();
  }

  void giamSoLuong(index){
    if(soLuong[index]>1){
      soLuong[index]--;
      tongTien.value=tongTien.value-cart[index].gia;
      update();
    }
  }

  void resetCart(){
    soLuong.value=[];
    cart.value=[];
    tongTien.value=0;
    update();
  }

}