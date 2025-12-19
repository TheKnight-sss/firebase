import 'package:fire/Components/buttons/main_button.dart';
import 'package:fire/core/Utils/colors.dart';
import 'package:fire/core/Utils/text_styles.dart';
import 'package:fire/core/constants/app_images.dart';
import 'package:fire/core/features/auth/models/doctor_model.dart';
import 'package:fire/core/features/patient/search/widgets/item_tile.dart';
import 'package:fire/core/features/patient/search/widgets/phone_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DoctorProfileScreen extends StatefulWidget {
  final DoctorModel? doctorModel;

  const DoctorProfileScreen({super.key, this.doctorModel});
  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: const Text(
          'بيانات الدكتور',
          style: TextStyle(color: AppColor.whiteColor),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // ------------ Header ---------------
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColor.whiteColor,
                        child: CircleAvatar(
                          backgroundColor: AppColor.whiteColor,
                          radius: 60,
                          backgroundImage: (widget.doctorModel?.image != null)
                              ? NetworkImage(widget.doctorModel!.image!)
                              : const AssetImage(AppImages.empty),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "د. ${widget.doctorModel?.name ?? ''}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.headLine.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.doctorModel?.specialization ?? '',
                          style: TextStyles.title,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              widget.doctorModel?.rating.toString() ?? '0.0',
                              style: TextStyles.title,
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            IconTile(
                              onTap: () {
                                var phone = Uri.parse(
                                  'tel:${widget.doctorModel?.phone1 ?? ''}',
                                );
                                launchUrl(phone);
                              },
                              backColor: AppColor.accentColor,
                              imgAssetPath: Icons.phone,
                              num: '1',
                            ),
                            if (widget.doctorModel?.phone2?.isNotEmpty == true)
                              IconTile(
                                onTap: () {
                                  var phone = Uri.parse(
                                    'tel:${widget.doctorModel?.phone2 ?? ''}',
                                  );
                                  launchUrl(phone);
                                },
                                backColor: AppColor.accentColor,
                                imgAssetPath: Icons.phone,
                                num: '2',
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              Text(
                "نبذه تعريفية",
                style: TextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.doctorModel?.bio ?? '', style: TextStyles.body),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text:
                          '${widget.doctorModel?.openingHours} - ${widget.doctorModel?.clossingHours}',
                      icon: Icons.watch_later_outlined,
                    ),
                    const SizedBox(height: 15),
                    TileWidget(
                      text: widget.doctorModel?.address ?? '',
                      icon: Icons.location_on_rounded,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Text(
                "معلومات الاتصال",
                style: TextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text: widget.doctorModel?.email ?? '',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 15),
                    TileWidget(
                      text: widget.doctorModel?.phone1 ?? '',
                      icon: Icons.call,
                    ),
                    if (widget.doctorModel?.phone2?.isNotEmpty == true) ...[
                      const SizedBox(height: 15),
                      TileWidget(
                        text: widget.doctorModel?.phone2 ?? '',
                        icon: Icons.call,
                      ),
                    ],
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
            text: 'احجز موعد الان',
            onPressed: () {
              // pushTo(context, Routes.booking_screen, extra: widget.doctorModel);
            },
          ),
        ),
      ),
    );
  }
}