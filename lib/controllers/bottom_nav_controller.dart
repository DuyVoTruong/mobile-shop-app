import 'package:get/get.dart';

class BottomNavController extends GetxController{
  RxInt index = RxInt(0);

  void selectIndex(int i){
    index.value = i;
    update();
  }
}