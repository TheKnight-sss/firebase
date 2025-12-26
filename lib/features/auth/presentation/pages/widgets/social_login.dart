import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.image, required this.txtbt});
  final String image;
  final String txtbt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image),
          Gap(10),
          Text(txtbt, style: TextStyles.title.copyWith(color: AppColor.greyColor)),
        ],
      ),
    );
  }
}
