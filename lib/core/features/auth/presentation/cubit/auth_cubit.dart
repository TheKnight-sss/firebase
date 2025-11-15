import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/core/features/auth/data/models/user_type_enum.dart';
import 'package:fire/core/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

   register({required UserTypeEnum type}) async {
    emit(AuthLoadingState());

    await Future.delayed(const Duration(seconds: 1));   

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          User? user = credential.user;
          await user?.updateDisplayName(nameController.text);

        //then store additional user info in firestore if needed
        FirebaseFirestore.instance.collection("user").doc(user?.uid).set({
          'uid': user?.uid,
          'name': nameController.text,
          'email': emailController.text,

        });

       

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureState("كلمة المرور ضعيفة جدا"));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureState("البريد الإلكتروني مستخدم بالفعل"));
      }else{
        emit(AuthFailureState("فشل في المصادقة, يرجى المحاولة مرة أخرى"));
      }
    } catch (e) {
      emit(AuthFailureState("فشل في المصادقة"));
    }
  }
}
