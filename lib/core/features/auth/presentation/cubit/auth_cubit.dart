import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/core/features/auth/models/doctor_model.dart';
import 'package:fire/core/features/auth/models/user_type_enum.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_state.dart';
import 'package:fire/core/functions/image_uploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? specialization;

  final bioController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final addressController = TextEditingController();
  final openHoursController = TextEditingController();
  final closeHoursController = TextEditingController();

  Future<void> login()async{
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
  
  emit(AuthSuccessState(role: credential.user?.photoURL));
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    emit(AuthFailureState("لا يوجد مستخدم بهذا البريد الإلكتروني"));
  } else if (e.code == 'wrong-password') {
    emit(AuthFailureState("كلمة المرور غير صحيحة"));
  }
}

  }

  Future<void> register({required UserTypeEnum type}) async {
    emit(AuthLoadingState());

    await Future.delayed(const Duration(seconds: 1));

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      //! Use photo URL as Role
       user?.updatePhotoURL(type == UserTypeEnum.doctor ? 'doctor' : 'patient');
      await user?.updateDisplayName(nameController.text);

      //then store additional user info in firestore if needed
      if (type == UserTypeEnum.doctor) {
        var doctor = DoctorModel(
          
          uid: user?.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseFirestore.instance
            .collection('doctors')
            .doc(user?.uid)
            .set(doctor.toJson());
      } else if (type == UserTypeEnum.patient) {
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(user?.uid)
            .set({
              'uid': user?.uid,
              'name': nameController.text,
              'email': emailController.text,
            });
      }

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState("كلمة المرور ضعيفة جدا"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState("البريد الإلكتروني مستخدم بالفعل"));
      } else {
        emit(AuthFailureState("فشل في المصادقة, يرجى المحاولة مرة أخرى"));
      }
    } catch (e) {
      emit(AuthFailureState("فشل في المصادقة"));
    }
  }

  Future<void> updateDoctorData([File? pickedImage]) async {
    emit(AuthLoadingState());

    try {
      String? imageUrl = await updateImageToCloudinary(pickedImage!);
      if (imageUrl == null) {
        emit(AuthFailureState("فشل في رفع الصورة"));
        return;
      }

      var doctor = DoctorModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        bio: bioController.text,
        phone1: phone1Controller.text,
        phone2: phone2Controller.text,
        address: addressController.text,
        openingHours: openHoursController.text,
        clossingHours: closeHoursController.text,
        specialization: specialization,
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.uid)
          .update(doctor.upUpdateData());
      emit(AuthSuccessState());
    } on Exception catch (_) {
      emit(AuthFailureState("فشل في تحديث البيانات"));
    }
  }
}
