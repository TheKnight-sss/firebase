import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/features/patient/presentation/pages/home_screen.dart';
import 'package:fire/core/features/patient/search/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PatientMainAppScreen extends StatefulWidget {
  const PatientMainAppScreen({super.key});

  @override
  State<PatientMainAppScreen> createState() => _PatientMainAppScreenState();
}

class _PatientMainAppScreenState extends State<PatientMainAppScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const PatientHomeScreen (),
    const SearchScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 8, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 20),
          ],
        ),
        child: GNav(
          curve: Curves.easeInOutExpo,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,
          gap: 5,
          activeColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: AppColor.primaryColor,
          textStyle: TextStyles.body.copyWith(color: AppColor.whiteColor),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'الرئيسية',
            ),
            GButton(
              icon: Icons.search,
              text: 'البحث',
            ),
            GButton(
              icon: Icons.calendar_month,
              text: 'الحجوزات',
            ),
            GButton(
              icon: Icons.person,
              text: 'الملف الشخصي',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
