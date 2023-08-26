import 'package:flutter/material.dart';

class CheckingDialog extends StatelessWidget {
  final String title;
  final String content;

  const CheckingDialog({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
