import 'dart:developer';

import 'package:fire/Components/buttons/main_button.dart';
import 'package:fire/Components/inputs/custom_text_field.dart';
import 'package:fire/Components/inputs/password_text_field.dart';
import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/constants/app_images.dart';
import 'package:fire/core/features/auth/data/models/user_type_enum.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_state.dart';
import 'package:fire/core/functions/dialogs.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:fire/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.userType});
  final UserTypeEnum userType;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 60),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              showLoadingDialog(context);
            } else if (state is AuthSuccessState) {
              log("Login Success");
              pop(context);
            } else if (state is AuthFailureState) {
              Navigator.pop(context);
              showMyDialog(context, state.errorMessage);
            }
          },
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppImages.logo, width: 250, height: 250),
                  Gap(20),
                  Text(
                    userType == UserTypeEnum.patient
                        ? "سجل دخول الان ك \"مريض\""
                        : "سجل دخول الان ك \"دكتور\"",
                    style: TextStyles.title.copyWith(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: cubit.emailController,
                    hint: "hamo@gmail.com",
                    maxLines: 1,
                    prefixIcon: Icon(Icons.email, color: AppColor.primaryColor),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.end,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'من فضلك ادخل البريد الالكتروني';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  PasswordTextField(
                    controller: cubit.passwordController,
                    hint: "********",
                    maxLines: 1,
                    prefixIcon: Icon(Icons.lock, color: AppColor.primaryColor),
                    textAlign: TextAlign.end,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'من فضلك ادخل كلمة السر';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      " نسيت كلمة السر؟",
                      style: TextStyles.body.copyWith(
                        color: AppColor.darkColor,
                      ),
                    ),
                  ),
                  Gap(20),
                  MainButton(
                    text: "تسجيل الدخول",
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        // cubit.login(type: userType);
                      }
                    },
                  ),
                  Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لديك حساب؟ ",
                        style: TextStyles.body.copyWith(
                          color: AppColor.darkColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pushwithReplacement(
                            context,
                            Routes.register,
                            extra: userType,
                          );
                        },
                        child: Text(
                          "انشاء حساب",
                          style: TextStyles.body.copyWith(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
