import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum Dialogs { error, success, warring }

showMyDialog(
  BuildContext context,
  String message, {
  Dialogs type = Dialogs.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyles.body()),
      backgroundColor: type == Dialogs.error
          ? Colors.red
          : type == Dialogs.success
          ? AppColor.primaryColor
          : AppColor.accentColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 0,
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColor.darkColor.withValues(alpha: 7),
    builder: (context) {
      return Center(
        child: Lottie.asset(
          "assets/images/Loading.json",
          width: 180,
          height: 180,
          fit: BoxFit.contain,
          repeat: true),
      );
    },
  );
}
