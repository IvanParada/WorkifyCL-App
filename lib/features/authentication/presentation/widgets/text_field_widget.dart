import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/core/themes/texts_theme.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.obscureText,
    this.validator,
    this.onTap,
    this.suffixIcon,
    required this.name,
    required this.labelText, this.keyboardType,
  });

  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final String name;
  final String labelText;
final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      cursorHeight: 15,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle:
            appTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300),
        contentPadding: const EdgeInsets.only(bottom: 2, left: 30),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.textPrimary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.textPrimary)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
