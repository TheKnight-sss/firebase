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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              showLoadingDialog(context);
            } else if (state is AuthSuccessState) {
              pop(context);
              log("Register Success");
            } else if (state is AuthFailureState) {
              Navigator.pop(context);
              showMyDialog(context, state.errorMessage);
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Image.asset(AppImages.logo, width: 250, height: 250),
                  Gap(20),
                  Text(
                    userType == UserTypeEnum.patient
                        ? "سجل حساب جديد ك \"مريض\""
                        : "سجل حساب جديد ك \"دكتور\"",
                    style: TextStyles.title.copyWith(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: cubit.nameController,
                    hint: "الاسم",
                    maxLines: 1,
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColor.primaryColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.end,
                  ),
                  Gap(20),
                  CustomTextField(
                    controller: cubit.emailController,
                    hint: "amr@gmail.com",
                    maxLines: 1,
                    prefixIcon: Icon(Icons.email, color: AppColor.primaryColor),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.end,
                    // validator: (p0) {
                    //   if (p0 == null || p0.isEmpty) {
                    //     return 'من فضلك ادخل الايميل';
                    //   } else if (!AppRegex().isValidEmail(p0)) {
                    //     return 'من فضلك ادخل الايميل بشكل صحيح';
                    //   } else {
                    //     return null;
                    //   }
                    // },
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
                  Gap(30),
                  MainButton(
                    text: "تسجيل حساب",
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.register(type: userType);
                      }
                    },
                  ),
                  Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " لديك حساب؟ ",
                        style: TextStyles.body.copyWith(
                          color: AppColor.darkColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pushwithReplacement(
                            context,
                            Routes.login,
                            extra: userType,
                          );
                        },
                        child: Text(
                          "تسجيل دخول",
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
