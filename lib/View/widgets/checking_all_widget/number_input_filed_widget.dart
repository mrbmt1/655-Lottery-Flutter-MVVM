import 'package:flutter/material.dart';

class NumberInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Color borderColor;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const NumberInputWidget({
    required this.controller,
    required this.borderColor,
    required this.focusNode,
    this.nextFocusNode,
  });

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
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 2,
            validator: (value) {
              return null;
            },
            focusNode: focusNode,
            onEditingComplete: () {
              focusNode.unfocus();
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 0),
              counterText: '',
            ),
          ),
        ),
      ),
    );
  }
}
