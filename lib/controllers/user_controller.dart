import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/favorite_controller.dart';
import 'package:mobile_shop_app/controllers/order_controller.dart';
import 'package:mobile_shop_app/models/user_model.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/show_dialog_message.dart';

class UserController extends GetxController {
  var userAuth = Rx(FirebaseAuth.instance?.currentUser);
  Rx<dynamic> user = Rx<dynamic>(null);
  Rx<dynamic> userById = Rx<dynamic>(null);

  @override
  void onInit() {
    super.onInit();
    if(FirebaseAuth.instance?.currentUser!=null){
      getUserByEmail(FirebaseAuth.instance?.currentUser!.email);
    }
  }

  Future signUp(context, emailController, passwordController, tenController, sdtController, diaChiController) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await FirebaseFirestore.instance.collection('User').add({
        "id": FirebaseFirestore.instance.collection('User').doc().id,
        "email": emailController.text,
        "password": passwordController.text,
        "ten": tenController.text,
        "sdt": sdtController.text,
        "diaChi": diaChiController.text,
        "isUser": true,
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add User: $error"));
      userAuth.value = FirebaseAuth.instance?.currentUser;
      getUserByEmail(FirebaseAuth.instance?.currentUser!.email);
      update();
      Get.toNamed(AppRoutes.verifyEmail);
    } on FirebaseException catch (e) {
      showDialog(
          context: context, builder: (context) => ShowDialogMessage(e: e));
    }
  }

  Future<void> updateAccount(tenController, sdtController, diaChiController) {
      return FirebaseFirestore.instance.collection('User')
          .doc(user.value.reference.id).update({
        "ten": tenController.text,
        "sdt": sdtController.text,
        "diaChi": diaChiController.text,
      })
          .then((value) {
        Get.back();
        Get.snackbar('Thông báo', 'Cập nhật tài khoản thành công', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
      })
          .catchError((error){
        Get.back();
        Get.snackbar('Thông báo', 'Cập nhật tài khoản không thành công!!! Vui lòng cập nhật lại', duration: const Duration(seconds: 3), backgroundColor: Colors.cyanAccent, isDismissible: true);
      });
  }

  Future signIn(context, emailController, passwordController) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      userAuth.value = FirebaseAuth.instance?.currentUser;
      getUserByEmail(FirebaseAuth.instance?.currentUser!.email);
      update();
      Get.offNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context, builder: (context) => ShowDialogMessage(e: e));
    }
  }

  void logout()async{
    await FirebaseAuth.instance.signOut();
    userAuth.value = await FirebaseAuth.instance?.currentUser;
    user.value=null;
    update();
    OrderController orderController = Get.put(OrderController());
    orderController.getHistoryOrderByUserId('');
    FavoriteController favoriteController = Get.put(FavoriteController());
    favoriteController.favoriteList.clear();
  }

  void getUserByEmail(email){
    FirebaseFirestore.instance.collection('User').where('email', isEqualTo: email).snapshots().listen((event) {
      user.value = UserModel(
          id: event.docs[0]['id'],
          email: event.docs[0]['email'],
          password: event.docs[0]['password'],
          ten: event.docs[0]['ten'],
          sdt: event.docs[0]['sdt'],
          diaChi: event.docs[0]['diaChi'],
          isUser: event.docs[0]['isUser'],
          reference: event.docs[0].reference);
      update();
      //print(user);
    });
  }

  void getUserById(userId){
    FirebaseFirestore.instance.collection('User').where('id', isEqualTo: userId).snapshots().listen((event) {
      userById.value = UserModel(
          id: event.docs[0]['id'],
          email: event.docs[0]['email'],
          password: event.docs[0]['password'],
          ten: event.docs[0]['ten'],
          sdt: event.docs[0]['sdt'],
          diaChi: event.docs[0]['diaChi'],
          isUser: event.docs[0]['isUser'],
          reference: event.docs[0].reference);
      update();
      //print(userById);
    });
  }

}
