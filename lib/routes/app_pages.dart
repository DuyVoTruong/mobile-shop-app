import 'package:get/get.dart';
import 'package:mobile_shop_app/main.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/forgot_password_page.dart';
import 'package:mobile_shop_app/views/login_page.dart';
import 'package:mobile_shop_app/views/register_page.dart';
import 'package:mobile_shop_app/views/seller/order%20management/add_order.dart';
import 'package:mobile_shop_app/views/seller/order%20management/order_detail.dart';
import 'package:mobile_shop_app/views/seller/order%20management/order_status_management.dart';
import 'package:mobile_shop_app/views/seller/product%20management/product_management_page.dart';
import 'package:mobile_shop_app/views/seller/seller_home_page.dart';
import 'package:mobile_shop_app/views/update_account_page.dart';
import 'package:mobile_shop_app/views/user/cart_page.dart';
import 'package:mobile_shop_app/views/user/favorite_page.dart';
import 'package:mobile_shop_app/views/user/history_page.dart';
import 'package:mobile_shop_app/views/user/order_status_page.dart';
import 'package:mobile_shop_app/views/user/rating_page.dart';
import 'package:mobile_shop_app/views/user/screen/filter_product.dart';
import 'package:mobile_shop_app/views/user/screen/product_detail.dart';
import 'package:mobile_shop_app/views/user/user_order_detail_page.dart';
import 'package:mobile_shop_app/views/user/search_page.dart';
import 'package:mobile_shop_app/views/verify_email.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const MyHomePage(),
      //binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: ()=>const HistoryPage(),
      //binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: ()=>const CartPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: ()=>const LoginPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.quanLySanPham,
      page: ()=>const ProductManagementPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.verifyEmail,
      page: ()=>const VerifyEmailPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: ()=>const RegisterPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: ()=>const ForgotPasswordPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.quanLyDonHang,
      page: ()=>const OrderStatusManagement(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.sellerHome,
      page: ()=>const SellerHomePage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: ()=>OrderDetail(order: Get.arguments[0]),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: ()=>ProductDetail(product: Get.arguments[0]),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.rating,
      page: ()=>const RatingPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.filterProduct,
      page: ()=>const FilterProductScreen(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.favorite,
      page: ()=>const FavoritePage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.orderStatus,
      page: ()=>const OrderStatusPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: ()=>const SearchPage(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.addOrder,
      page: ()=>const AddOrder(),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.userOrderDetail,
      page: ()=>UserOrderDetailPage(order: Get.arguments[0]),
      //binding: CountBinding(),
    ),
    GetPage(
      name: AppRoutes.updateAccount,
      page: ()=>const UpdateAccountPage(),
      //binding: CountBinding(),
    ),
  ];
}