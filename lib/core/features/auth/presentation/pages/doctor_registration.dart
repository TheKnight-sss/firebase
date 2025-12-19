import 'dart:io';

import 'package:fire/Components/buttons/main_button.dart';
import 'package:fire/Components/inputs/custom_text_field.dart';
import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/constants/app_images.dart';
import 'package:fire/core/features/auth/models/specialization.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_state.dart';
import 'package:fire/core/functions/dialogs.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class DoctorRegestration extends StatefulWidget {
  const DoctorRegestration({super.key});

  @override
  State<DoctorRegestration> createState() => _DoctorRegestrationState();
}

class _DoctorRegestrationState extends State<DoctorRegestration> {
  bool? isShowingError;
  File? file;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSuccessState) {
          pop(context);
          // pushwithReplacement(context, Routes.doctor_main);
        } else if (state is AuthFailureState) {
          pop(context);
          showMyDialog(context, state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: Text(
            "استكمال التسجيل",
            style: TextStyles.title.copyWith(color: AppColor.whiteColor),
          ),
          iconTheme: IconThemeData(color: AppColor.whiteColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      MainButton(
                                        text: "الكاميرا",
                                        onPressed: () {
                                          uploadImages(isCamera: true);
                                        },
                                        textColor: AppColor.whiteColor,
                                        bgColor: AppColor.primaryColor
                                            .withValues(alpha: 0.5),
                                      ),
                                      Gap(10),
                                      MainButton(
                                        text: "المعرض",
                                        onPressed: () {
                                          uploadImages(isCamera: false);
                                        },
                                        textColor: AppColor.whiteColor,
                                        bgColor: AppColor.primaryColor
                                            .withValues(alpha: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColor.whiteColor,
                            backgroundImage: (file != null)
                                ? FileImage(file!)
                                : const AssetImage(AppImages.empty),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.whiteColor,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColor.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "التخصص",
                    style: TextStyles.title.copyWith(
                      color: AppColor.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.accentColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DropdownButton<String?>(
                      menuMaxHeight: 300,
                      icon: Icon(
                        Icons.expand_circle_down_outlined,
                        color: AppColor.primaryColor,
                      ),
                      iconEnabledColor: AppColor.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: Text("اختر التخصص"),
                      value: cubit.specialization,
                      items: [
                        for (var specializat in specialization)
                          DropdownMenuItem(
                            value: specializat,
                            child: Text(specializat),
                          ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          cubit.specialization = newValue;
                        });
                      },
                    ),
                  ),
                  Gap(10),
                  Text(
                    "نبذة عني",
                    style: TextStyles.title.copyWith(
                      color: AppColor.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    hint:
                        "سجل المعلومات الطبيه العامه مثل تعليمك الاكاديمي و خبراتك السابقة",
                    maxLines: 5,
                    controller: cubit.bioController,
                  ),
                  Gap(10),
                  Divider(),
                  Gap(10),
                  Text(
                    "العنوان",
                    style: TextStyles.title.copyWith(
                      color: AppColor.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomTextField(
                    keyboardType: TextInputType.streetAddress,
                    textAlign: TextAlign.start,
                    hint: "ادخل العنوان",
                    controller: cubit.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "برجاء ادخال العنوان";
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " ساعات العمل من",
                              style: TextStyles.title.copyWith(
                                color: AppColor.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            Gap(10),
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "برجاء ادخال ساعة بدء العمل ";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              textAlign: TextAlign.start,
                              hint: '10:00 صباحاً',
                              readOnly: true,
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.primaryColor,
                              ),
                              onTap: () async {
                                // Pick a full time first
                                await showStartTimePicker(context, cubit);
                              },
                              controller: cubit.openHoursController,
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "إلى",
                              style: TextStyles.title.copyWith(
                                color: AppColor.darkColor,
                                fontSize: 15,
                              ),
                            ),
                            Gap(10),
                            CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "برجاء ادخال ساعة انتهاء العمل ";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              textAlign: TextAlign.start,
                              hint: '10:00 مساءً',
                              readOnly: true,
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.primaryColor,
                              ),
                              onTap: () async {
                                // Pick a full time first
                                await showEndTimePicker(context, cubit);
                              },
                              controller: cubit.closeHoursController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Text(
                    "رقم الهاتف الأول",
                    style: TextStyles.title.copyWith(
                      color: AppColor.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomTextField(
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    hint: '+20xxxxxxxxxxx',
                    controller: cubit.phone1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "برجاء ادخال رقم الهاتف";
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  Text(
                    "رقم الهاتف الثاني",
                    style: TextStyles.title.copyWith(
                      color: AppColor.darkColor,
                      fontSize: 15,
                    ),
                  ),
                  Gap(10),
                  CustomTextField(
                    controller: cubit.phone2Controller,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    hint: '+20xxxxxxxxxxx',
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: MainButton(
            text: "تسجيل",
            onPressed: () async {
              setState(() {
                isShowingError = true;
              });
              if (cubit.formKey.currentState!.validate()) {
                if (file != null) {
                  await cubit.updateDoctorData(file);
                }
                else {
                  showMyDialog(context, "برجاء اختيار صورة الملف الشخصي");
                }
              }
            },
            bgColor: AppColor.primaryColor,
            textColor: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }

  Future<void> showEndTimePicker(BuildContext context, AuthCubit cubit) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      int hour24 = selectedTime.hour;
      int minute = selectedTime.minute;

      cubit.closeHoursController.text =
          '${hour24.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> showStartTimePicker(
    BuildContext context,
    AuthCubit cubit,
  ) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context), child: child!);
      },
    );

    if (selectedTime != null) {
      int hour24 = selectedTime.hour;
      int minute = selectedTime.minute;

      // Format it as HH:00  (24-hour system)
      cubit.openHoursController.text =
          '${hour24.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }

  Future<void> uploadImages({required bool isCamera}) async {
    XFile? pickedfile = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedfile != null) {
      setState(() {
        pop(context);
        file = File(pickedfile.path);
      });
    }
  }
}
