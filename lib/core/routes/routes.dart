import 'package:fire/core/features/auth/models/doctor_model.dart';
import 'package:fire/core/features/auth/models/user_type_enum.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fire/core/features/auth/presentation/pages/doctor_registration.dart';
import 'package:fire/core/features/auth/presentation/pages/login_screen.dart';
import 'package:fire/core/features/auth/presentation/pages/register_screen.dart';
import 'package:fire/core/features/doctor/pages/doctor_home.dart';
import 'package:fire/core/features/intro/onboarding/onboarding_screen.dart';
import 'package:fire/core/features/intro/splash/splash_screen.dart';
import 'package:fire/core/features/intro/welcome/welcome_screen.dart';
import 'package:fire/core/features/main/nav_bar.dart';
import 'package:fire/core/features/patient/presentation/pages/home_screen.dart';
import 'package:fire/core/features/patient/presentation/pages/home_search_screen.dart';
import 'package:fire/core/features/patient/presentation/pages/specialization_search.dart';
import 'package:fire/core/features/patient/search/pages/doctor_profile_screen.dart';
import 'package:fire/core/features/patient/search/pages/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String docregister = '/docregister';
  static const String patientmain = '/patientmain';
  static const String patienthome = '/patienthome';
  static const String doctorhome = '/doctorhome';
  static const String specializationsearch = '/specializationsearch';
  static const String homesearch= '/homesearch';
  static const String searchscreen= '/searchscreen';
  static const String doctorprofile= '/doctorprofile';

  static GoRouter routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: docregister,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: DoctorRegestration(),
        ),
      ),
      GoRoute(
        path: patientmain,
        builder: (context, state) => const PatientMainAppScreen(),
      ),
      GoRoute(
        path: patienthome,
        builder: (context, state) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: doctorhome,
        builder: (context, state) => const DoctorHome(),
      ),
      GoRoute(
        path: specializationsearch,
        builder: (context, state) => SpecializationSearchScreen(specialization: state.extra as String,),
      ),
      GoRoute(
        path: homesearch,
        builder: (context, state) => HomeSearchScreen(specialization: state.extra as String,),
      ),
      GoRoute(
        path: doctorprofile,
        builder: (context, state) => DoctorProfileScreen(doctorModel: state.extra as DoctorModel?),
      ),
      
    ],
  );
}
