import 'package:fire/Components/buttons/main_button.dart';
import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pagecontroller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: Text("تخطي"))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pagecontroller,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SvgPicture.asset(AppImages.on1),
                      Text(
                        "عنوان الشاشة$index",
                        style: TextStyles.title.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      const Gap(10),
                      Text("وصف الشاشة$index", style: TextStyles.body),
                    ],
                  );
                },
                itemCount: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pagecontroller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColor.primaryColor,
                      dotColor: AppColor.accentColor,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  MainButton(
                    text: "هيا بنا",
                    onPressed: () {},
                    width: 100,
                    height: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
