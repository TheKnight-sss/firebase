import 'package:fire/Components/buttons/main_button.dart';
import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/features/onboarding/onboarding_model.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:fire/core/routes/routes.dart';
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
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (currentindex != onboardingList.length - 1)
            TextButton(onPressed: () {}, child: Text("تخطي")),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentindex = index;
                  });
                },
                controller: pagecontroller,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SvgPicture.asset(
                        onboardingList[index].imagepath,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                      ),
                      Spacer(),
                      Text(
                        onboardingList[index].title,
                        style: TextStyles.title.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          onboardingList[index].description,
                          style: TextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 3),
                    ],
                  );
                },
                itemCount: onboardingList.length,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pagecontroller,
                    count: onboardingList.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColor.primaryColor,
                      dotColor: AppColor.accentColor,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  if (currentindex == onboardingList.length - 1)
                    MainButton(
                      text: "هيا بنا",
                      onPressed: () {
                        pushTo(context, Routes.welcome);
                      },
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
