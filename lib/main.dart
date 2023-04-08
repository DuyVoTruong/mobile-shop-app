import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/bindings/home_binding.dart';
import 'package:mobile_shop_app/routes/app_pages.dart';
import 'package:mobile_shop_app/views/user/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyCK2i7X4q7kWWt_Xb8wJcsQlZqsiKIfCPc"
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
      debugShowCheckedModeBanner: false,
      title: 'Mobile Shop App',
      //theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: HomeBinding(),
      home: HomePage(),
      getPages: AppPages.pages,
    );
  }

}

/*
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePage createState()=> _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  static BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: controller.index==0
          ?HomePage():controller.index==1?HistoryPage():CartPage(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
 */