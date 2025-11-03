import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.maxLines,
    this.minLines,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
  });

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      onTap: onTap,
      decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
