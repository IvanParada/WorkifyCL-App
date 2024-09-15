import 'package:flutter/material.dart';

class AutoFocusTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? onChanged;

  const AutoFocusTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),
        onChanged: (text) {
          if (text.length == 1 && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
          if (onChanged != null) {
            onChanged!(text);
          }
        },
      ),
    );
  }
}
