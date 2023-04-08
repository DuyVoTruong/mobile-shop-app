import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/models/user_model.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';
import 'package:mobile_shop_app/views/show_dialog_message.dart';

class UserController extends GetxController {
  var user = Rx(FirebaseAuth.instance?.currentUser);
  var userByEmail = Rx<String>('');
  var userId = Rx<String>('');

  @override
  void onInit() {
    super.onInit();
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
      user.value = FirebaseAuth.instance?.currentUser;
      getUserByEmail(FirebaseAuth.instance?.currentUser!.email);
      update();
      Get.toNamed(AppRoutes.verifyEmail);
    } on FirebaseException catch (e) {
      showDialog(
          context: context, builder: (context) => ShowDialogMessage(e: e));
    }
  }

  Future signIn(context, emailController, passwordController) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      user.value = FirebaseAuth.instance?.currentUser;
      getUserByEmail(FirebaseAuth.instance?.currentUser!.email);
      update();
      Get.toNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context, builder: (context) => ShowDialogMessage(e: e));
    }
  }

  void logout()async{
    await FirebaseAuth.instance.signOut();
    user.value = await FirebaseAuth.instance?.currentUser;
    userByEmail.value='';
    userId.value='';
    update();
  }

  void getUserByEmail(email){
    FirebaseFirestore.instance.collection('User').where('email', isEqualTo: email).snapshots().listen((event) {
      userByEmail.value = event.docs[0]['ten'];
      userId.value = event.docs[0]['id'];
      update();
    });
  }

}
