import 'package:flutter/material.dart';

Widget resultText() {
  return Text(
    "Kết quả xổ số",
    style: TextStyle(
      fontSize: 28,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          offset: const Offset(3.0, 3.0),
          blurRadius: 3.0,
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    ),
  );
}
