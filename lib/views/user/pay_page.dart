import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PayPage extends StatelessWidget{
  const PayPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán bằng thẻ tín dụng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            CardFormField(
              controller: CardFormEditController(),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){

                },
                child: const Text('Thanh toán'),
            ),
          ],
        ),
      ),
    );
  }
}