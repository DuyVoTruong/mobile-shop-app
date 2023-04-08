import 'package:get/get.dart';
import 'package:mobile_shop_app/bindings/home_binding.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/forgot_password_page.dart';
import 'package:mobile_shop_app/views/login_page.dart';
import 'package:mobile_shop_app/views/register_page.dart';
import 'package:mobile_shop_app/views/seller/order%20management/order_detail.dart';
import 'package:mobile_shop_app/views/seller/order%20management/order_management_page.dart';
import 'package:mobile_shop_app/views/seller/product%20management/product_management_page.dart';
import 'package:mobile_shop_app/views/seller/seller_home_page.dart';
import 'package:mobile_shop_app/views/user/cart_page.dart';
import 'package:mobile_shop_app/views/user/history_page.dart';
import 'package:mobile_shop_app/views/user/home_page.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';
import 'package:mobile_shop_app/views/verify_email.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      //binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: ()=>HistoryPage(),
      //binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: ()=>CartPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: ()=>LoginPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.quanLySanPham,
      page: ()=>ProductManagementPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.verifyEmail,
      page: ()=>VerifyEmailPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: ()=>RegisterPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: ()=>ForgotPasswordPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.quanLyDonHang,
      page: ()=>OrderManagementPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.sellerHome,
      page: ()=>SellerHomePage(),
      //binding: CountBinding(),
    ),
  ];
}