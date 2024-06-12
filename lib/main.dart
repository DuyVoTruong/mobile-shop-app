import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/bindings/home_binding.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_pages.dart';
import 'package:mobile_shop_app/views/login_page.dart';
import 'package:mobile_shop_app/views/seller/seller_home_page.dart';
import 'package:mobile_shop_app/views/user/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51N8O96JxElY6vLQWxQGEfjlEIj9IptS8hL5jv7C2ScNqfR62VZN2aBqWgdLT6NECkgVJghZcML0Mzmt92JotVby900sVZWvpv0";
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyCK2i7X4q7kWWt_Xb8wJcsQlZqsiKIfCPc"
          , appId: ""
          , messagingSenderId: ""
          ,
          projectId: "bandienthoaiapp")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 18.0),
          bodyText2: TextStyle(fontSize: 16.0),
        )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mobile Shop App',
      //theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: HomeBinding(),
      home: const LoginPage(),
      getPages: AppPages.pages,
    );
  }

}


class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState()=> _MyHomePage();

}

class _MyHomePage extends State<MyHomePage>{

  static UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Obx(() => controller.user.value==null?const LoginPage():controller.user.value.isUser==true?const HomePage():const SellerHomePage()),
    );
  }

}