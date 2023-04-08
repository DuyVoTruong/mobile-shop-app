import 'package:flutter/material.dart';

class ShowDialogMessage extends StatelessWidget {
  const ShowDialogMessage({super.key, this.e});

  final e;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Message"),
      content: Text(e.message.toString()),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
