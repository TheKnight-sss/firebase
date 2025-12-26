import 'package:fire/core/constants/app_images.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagepath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagepath,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: "ابحث عن دكتور متخصص",
    description: "اكتشف مجموعة رائعة من الخبراء و المتخصصين غي مختلف المجالات",
    imagepath: AppImages.on1,
  ),
  OnboardingModel(
    title: "سهولة الحجز",
    description: "احجز المواعيد بضغطة زرار بسهولة في اي وقت و أي مكان",
    imagepath: AppImages.on2,
  ),
  OnboardingModel(
    title: "أمن و سري",
    description: "كن مطمئنا لان خصوصيتك أهم أولوياتنا",
    imagepath: AppImages.on1,
  ),
];
