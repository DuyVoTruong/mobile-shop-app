import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final tenController = TextEditingController();
  final sdtController = TextEditingController();
  final diaChiController = TextEditingController();

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
                  child: Text("Sign Up",
                    style: TextStyle(
                        fontSize: 35.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ?'Enter a valid email'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 characters'
                        : null,
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
                    onPressed: ()=>controller.signUp(context, emailController, passwordController, tenController, sdtController, diaChiController),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: const Size(150, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          child: Icon(Icons.login_outlined),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: Text("Sign up"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          text: 'Have an account? ',
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()..onTap=(){
                                  Get.toNamed(AppRoutes.login);
                                },
                                text: 'Login',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                )
                            )
                          ]
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}