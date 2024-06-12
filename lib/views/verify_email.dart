import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_app/views/user/home_page.dart';

class VerifyEmailPage extends StatefulWidget{
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPage();
}

class _VerifyEmailPage extends State<VerifyEmailPage>{
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified(),);
    }
  }

  @override
  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail=false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
    appBar: AppBar(
      title: const Text('Verify Email'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'A verification email has been sent to your email',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: canResendEmail ? sendVerificationEmail:null,
            icon: const Icon(Icons.email),
            label: const Text(
              'Resent Email',
            ),
          ),
          const SizedBox(height: 8,),
          TextButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50)
            ),
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              'Cancel',
            ),
          ),
        ],
      ),
    ),
  );
}