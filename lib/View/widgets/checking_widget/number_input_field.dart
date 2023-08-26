import 'package:flutter/material.dart';

class NumberInputField extends StatefulWidget {
  final TextEditingController controller;
  final Color borderColor;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  const NumberInputField({
    super.key,
    required this.controller,
    required this.borderColor,
    required this.focusNode,
    required this.nextFocusNode,
  });

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            maxLength: 2,
            validator: (value) {
              return null;
            },
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            focusNode: widget.focusNode,
            onEditingComplete: () {
              widget.focusNode.unfocus();
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            },
          ),
        ),
      ),
    );
  }
}
