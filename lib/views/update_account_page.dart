import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class UpdateAccountPage extends StatefulWidget{
  const UpdateAccountPage({super.key});

  @override
  State<UpdateAccountPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<UpdateAccountPage>{
  static UserController userController = Get.put(UserController());
  final tenController = TextEditingController(text: userController.user.value.ten);
  final sdtController = TextEditingController(text: userController.user.value.sdt);
  final diaChiController = TextEditingController(text: userController.user.value.diaChi);

  static UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                  child: Text("Update Account",
                    style: TextStyle(
                        fontSize: 35.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: tenController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Tên'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: sdtController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('SĐT'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    controller: diaChiController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Địa chỉ'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: ()=>controller.updateAccount(tenController, sdtController, diaChiController),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: const Size(150, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          child: Icon(Icons.edit),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: Text("Update"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}