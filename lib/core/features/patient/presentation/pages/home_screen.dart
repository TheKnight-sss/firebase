import 'dart:async';

import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/features/patient/presentation/widget/specialists_widget.dart';
import 'package:fire/core/features/patient/presentation/widget/top_rated.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:fire/core/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomeScreen> {
  final TextEditingController _doctorName = TextEditingController();
  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_active,
              color: AppColor.darkColor,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        title: Text(
          'صــــــحّـتــي',
          style: TextStyles.headLine.copyWith(
            color: AppColor.darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'مرحبًا، ',
                      style: TextStyles.title.copyWith(
                        color: AppColor.darkColor,
                      ),
                    ),
                    TextSpan(
                      text: user?.displayName ?? '',
                      style: TextStyles.title.copyWith(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                "احجز الآن وكن جزءًا من رحلتك الصحية.",
                style: TextStyles.headLine.copyWith(
                  color: AppColor.darkColor,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _doctorName,
                  cursorColor: AppColor.primaryColor,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintStyle: TextStyles.title,
                    filled: true,
                    hintText: 'ابحث عن دكتور',
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: IconButton(
                        iconSize: 20,
                        splashRadius: 20,
                        color: Colors.white,
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (_doctorName.text.isNotEmpty) {
                            pushTo(
                              context,
                              Routes.homesearch,
                              extra: _doctorName.text,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  style: TextStyles.title,
                  //! onFieldSubmitted works when user press enter on keyboard
                  onFieldSubmitted: (String value) {
                    if (_doctorName.text.isNotEmpty) {
                      pushTo(
                        context,
                        Routes.homesearch,
                        extra: _doctorName.text,
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),

              const SpecialistsBanner(),
              const SizedBox(height: 10),

              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: TextStyles.headLine.copyWith(
                  fontSize: 16,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
               TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }
}
