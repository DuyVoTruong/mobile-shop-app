import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_shop_app/controllers/user_controller.dart';
import 'package:mobile_shop_app/routes/app_routes.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
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
                  child: Text("Login",
                    style: TextStyle(
                        fontSize: 35.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    onEditingComplete: (){
                      controller.signIn(context, emailController, passwordController);
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: ()=>controller.signIn(context, emailController, passwordController),
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
                          child: Text("Login"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: (){
                      Get.toNamed(AppRoutes.forgotPassword);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        text: 'No account? ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Get.toNamed(AppRoutes.register);
                            },
                            text: 'Sign up',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                /*Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (){
                          Get.back();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            Text(' To Home Page')
                          ],
                        )
                      )
                    ],
                  )
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}