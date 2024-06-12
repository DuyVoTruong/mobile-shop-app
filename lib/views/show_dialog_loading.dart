import 'package:flutter/material.dart';

class ShowDialogLoading extends StatelessWidget {
  const ShowDialogLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          CircularProgressIndicator(),
          Text("  Loading...."),
        ],
      ),
    );
  }
}
