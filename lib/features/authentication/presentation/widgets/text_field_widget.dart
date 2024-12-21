import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.obscureText,
    this.validator,
    this.onTap,
    this.suffixIcon,
    required this.name,
    required this.labelText,
    this.keyboardType,
    this.maxLines,
    this.onChanged,
    this.initialValue,
    this.controller,
  });

  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final String name;
  final String labelText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final ValueChanged<String?>? onChanged;
  final String? initialValue;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      controller: controller,
      initialValue: initialValue,
      cursorHeight: 15,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle:
            appTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.w300),
        contentPadding: const EdgeInsets.only(bottom: 2, left: 30, right: 30),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.textPrimary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.textPrimary)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
