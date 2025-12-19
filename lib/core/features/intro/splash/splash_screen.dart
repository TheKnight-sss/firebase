import 'package:fire/core/Services/local/local_helper.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:fire/core/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      bool seen = SharedPref.isOnboardingsSeen();
      var user = FirebaseAuth.instance.currentUser;

      Future.delayed(const Duration(seconds: 2), () {
        if (user != null) {
          if (user.photoURL == "doctor") {
            pushwithReplacement(context, Routes.welcome);
          } else {
            pushwithReplacement(context, Routes.patientmain);
          }
        } else {
          if (seen) {
            pushwithReplacement(context, Routes.welcome);
          } else {
            pushwithReplacement(context, Routes.onboarding);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center());
  }
}
