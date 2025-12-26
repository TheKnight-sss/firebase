import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

showsnackbar(
  BuildContext context, {
  String? ok,
  String? no,
  required String title,
  void Function()? onTap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColor.accentColor,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(Icons.check, size: 50, color: AppColor.darkColor),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyles.headLine.copyWith(color: AppColor.darkColor),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (ok != null)
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.primaryColor,
                          ),
                          child: Text(
                            ok,
                            style: TextStyles.title.copyWith(
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    if (no != null)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.accentColor,
                          ),
                          child: Text(no, style: TextStyles.title),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}