import 'package:flutter/material.dart';

class NumberResultRow extends StatelessWidget {
  final String result;
  final Color borderColor;

  const NumberResultRow(
      {super.key, required this.result, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
