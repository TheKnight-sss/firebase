import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/constants/app_images.dart';
import 'package:fire/core/features/auth/data/models/user_type_enum.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:fire/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcome,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          PositionedDirectional(
            top: 100,
            start: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "أهلا بيك",
                  style: TextStyles.title.copyWith(
                    fontSize: 38,
                    color: AppColor.primaryColor,
                  ),
                ),
                const Gap(15),
                Text("أحجز عند دكتورك و أنت في البيت", style: TextStyles.body),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 80,
            end: 25,
            start: 25,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "سجل دلوقتي كــ",
                    style: TextStyles.title.copyWith(
                      color: AppColor.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildUserButton(
                    title: "دكتور",
                    onTap: () {
                      pushTo(context, Routes.login, extra: UserTypeEnum.doctor);
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildUserButton(
                    title: "مريض",
                    onTap: () {
                      pushTo(
                        context,
                        Routes.login,
                        extra: UserTypeEnum.patient,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildUserButton({
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColor.accentColor.withValues(alpha: .7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyles.title.copyWith(color: AppColor.darkColor),
          ),
        ),
      ),
    );
  }
}
