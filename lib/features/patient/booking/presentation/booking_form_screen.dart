import 'package:fire/Components/buttons/main_button.dart';
import 'package:fire/Components/cards/doctor_card.dart';
import 'package:fire/Services/firebase/firestore_services.dart';
import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/functions/dialogs.dart';
import 'package:fire/core/functions/snackbar.dart';
import 'package:fire/core/routes/navigation.dart';
import 'package:fire/core/routes/routes.dart';
import 'package:fire/features/auth/models/doctor_model.dart';
import 'package:fire/features/patient/booking/data/appoitment_model.dart';
import 'package:fire/features/patient/booking/data/available_appointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class BookingFormScreen extends StatefulWidget {
  final DoctorModel doctor;

  const BookingFormScreen({super.key, required this.doctor});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  int selectedHour = -1;

  List<int> availableHours = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'احجز مع دكتورك',
          style: TextStyle(color: AppColor.whiteColor),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DoctorCard(doctor: widget.doctor, isClickable: false),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '-- ادخل بيانات الحجز --',
                        style: TextStyles.title.copyWith(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'اسم المريض',
                      style: TextStyles.title.copyWith(
                        color: AppColor.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
                        return null;
                      },
                      style: TextStyles.title.copyWith(),
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'رقم الهاتف',
                      style: TextStyles.title.copyWith(
                        color: AppColor.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      style: TextStyles.title.copyWith(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 10) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'وصف الحاله',
                      style: TextStyles.title.copyWith(
                        color: AppColor.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyles.title.copyWith(),
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'تاريخ الحجز',
                      style: TextStyles.title.copyWith(
                        color: AppColor.darkColor,
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        selectDate(context);
                      },
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل تاريخ الحجز';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyles.title.copyWith(),
                      decoration: const InputDecoration(
                        hintText: 'ادخل تاريخ الحجز',
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            radius: 18,
                            child: Icon(
                              Icons.date_range_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وقت الحجز',
                            style: TextStyles.title.copyWith(
                              color: AppColor.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (var hour in availableHours)
                          ChoiceChip(
                            backgroundColor: AppColor.accentColor,
                            showCheckmark: true,
                            checkmarkColor: AppColor.whiteColor,
                            selectedColor: AppColor.primaryColor,
                            label: Text(
                              '${(hour < 10) ? '0' : ''}'
                              '${hour.toString()}'
                              ':00',
                              style: TextStyle(
                                color: hour == selectedHour
                                    ? AppColor.whiteColor
                                    : AppColor.darkColor,
                              ),
                            ),
                            selected: hour == selectedHour,
                            onSelected: (_) {
                              setState(() {
                                selectedHour = hour;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: MainButton(
            text: 'تأكيد الحجز',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (selectedHour != -1) {
                  _createAppointment();
                } else {
                  showMyDialog(context, 'من فضلك اختر وقت الحجز');
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    var appointmentData = AppointmentModel(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      patientID: FirebaseAuth.instance.currentUser?.uid ?? "",
      doctorID: widget.doctor.uid ?? '',
      name: _nameController.text,
      doctorName: widget.doctor.name ?? '',
      phone: _phoneController.text,
      description: _descriptionController.text,
      location: widget.doctor.address ?? '',
      date: DateTime.parse(
        '${_dateController.text} ${(selectedHour < 10) ? '0' : ''}$selectedHour:00:00',
      ),
      isComplete: false,
    );
    await FirestoreServices.createAppointment(appointmentData).then((_) {
      showsnackbar(
        context,
        title: 'تم تسجيل الحجز !',
        ok: 'اضغط للانتقال',
        onTap: () {},
      );
      Future.delayed(const Duration(seconds: 3), () {
        pop(context);
        // pushwithReplacement(context, Routes.patent_main);
      });
    });
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((date) {
      if (date != null) {
        _dateController.text = DateFormat('yyyy-MM-dd').format(date);

        availableHours = getAvailableAppointments(
          date,
          widget.doctor.openingHours ?? "0",
          widget.doctor.clossingHours ?? "0",
        );
        setState(() {});
      }
    });
  }
}