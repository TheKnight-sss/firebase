import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/login/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/register/page/register_screen.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/page/place_order_screen.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/pages/details_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String details = '/details';
  static const String placeOrder = '/place-order';

  static GoRouter routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: main,
        builder: (context, state) =>
             MainAppScreen(index: state.extra as int?),
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          var book = state.extra as Product;
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: DetailsScreen(book: book),
          );
        },
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => CartCubit()..prefillOrderDate(),
            child: PlaceOrderScreen(total: state.extra as String),
          );
        },
      ),
    ],
  );
}
