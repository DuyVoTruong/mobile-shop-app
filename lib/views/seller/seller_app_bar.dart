import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class SellerAppBar extends StatelessWidget with PreferredSizeWidget{

  const SellerAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  static UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context){

    void handleClick(int value, context) {
      switch (value) {
        case 0:
          Get.toNamed(AppRoutes.quanLySanPham);
          break;
        case 1:
          Get.toNamed(AppRoutes.quanLyDonHang);
          break;
        case 2:
          userController.logout();
          Get.toNamed(AppRoutes.home);
          break;
        case 3:
          Get.toNamed(AppRoutes.updateAccount);
          break;
        case 4:
          Get.toNamed(AppRoutes.forgotPassword);
          break;
      }
    }

    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.black12,
      automaticallyImplyLeading: false,
      title: const Text("Mobile Shop", style: TextStyle(color: Colors.black),),
      actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (item) => handleClick(item, context),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('Quản lý sản phẩm')),
            const PopupMenuItem<int>(value: 1, child: Text('Quản lý đơn hàng')),
            const PopupMenuItem<int>(value: 3, child: Text('Cập nhật tài khoản')),
            const PopupMenuItem<int>(value: 4, child: Text('Thay đổi mật khẩu')),
            const PopupMenuItem<int>(value: 2, child: Text('Log out')),
          ],
        ),
      ],
    );
  }
}