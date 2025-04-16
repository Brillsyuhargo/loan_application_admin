import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/routes/my_app_route.dart';
import 'package:loan_application_admin/widgets/app_button.dart';
import 'package:loan_application_admin/widgets/custom_text.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Image.asset(
                    'assets/images/logo_ksp.png',
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Admin',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    text: 'KSP UTAMA KARYA',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                  ),
                  Spacer(),
                  CustomButton(
                    text: 'Log Out',
                    onPressed: () {
                      Get.toNamed(MyAppRoutes.loginScreen);
                    },
                    color: AppColors.lightBlue,
                    borderRadius: 15,
                    textStyle: TextStyle(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                    paddingVertical: 15,
                    paddingHorizontal: 50,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
