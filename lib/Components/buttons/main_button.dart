import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';


class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.bgColor = AppColor.primaryColor,
    this.borderColor,
    this.textColor,
  });

  final String text;
  final double? height;
  final double? width;
  final Function() onPressed;
  final Color bgColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          side: borderColor != null
              ? BorderSide(color: borderColor ?? AppColor.darkColor)
              : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.styleSize20(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
