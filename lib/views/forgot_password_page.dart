import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget{
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage>{

  final emailController = TextEditingController();
  Future verifyEmail() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Message"),
          content: Text("Password Reset Email Sent"),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      );
    } on FirebaseException catch (e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Message"),
          content: Text(e.message.toString()),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Text("Reset Password",
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
              child: ElevatedButton(
                onPressed: verifyEmail,
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
                      child: Text("Reset Password"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}