import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  final int number;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final Color shadowColor;

  const NumberWidget({
    super.key,
    required this.number,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientStartColor, gradientEndColor],
        ),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        "$number".toString().padLeft(2, '0'),
        style: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
