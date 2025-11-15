import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.textAlign = TextAlign.start,
    this.keyboardType,
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
  final TextInputType? keyboardType;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      onTap: onTap,
      inputFormatters: [
        // LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.-_]")),
      ],
      keyboardType: keyboardType,
      textAlign: textAlign,
      decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
