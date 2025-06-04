import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_NominalPinjaman.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_nilaiPinjaman.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/field_readonly.dart';
import 'package:loan_application_admin/widgets/custom_appbar.dart';

class DetailSurvey extends StatefulWidget {
  const DetailSurvey({super.key});

  @override
  State<DetailSurvey> createState() => _DetailSurveyState();
}

class _DetailSurveyState extends State<DetailSurvey> {
  final InqurySurveyController inquryController =
      Get.put(InqurySurveyController());

  @override
  void initState() {
    super.initState();
    final trxSurvey = Get.arguments;
    inquryController.getSurveyList(trxSurvey: trxSurvey.toString());
    print("trx survey: $trxSurvey");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Detail Survey',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldReadonly(
                        label: 'Tujuan Pinjaman',
                        width: double.infinity,
                        height: 50,
                        value: inquryController.purpose.value,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 4),
                      FieldReadonly(
                        label: 'Category Agunan',
                        width: double.infinity,
                        height: 50,
                        value: inquryController.id_name.value,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 4),
                      FieldReadonly(
                        label: 'Category Document',
                        width: double.infinity,
                        height: 50,
                        value: inquryController.adddescript.value,
                        keyboardType: TextInputType.text,
                      ),
                      //ini garis yoo
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      // Widget untuk text numer
                      Loan_angkaPinjaman(),
                      NilaiPinjaman(),
                    ],
                  )),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(MyAppRoutes.detaildocumen,
                      arguments: Get.arguments), // Pass the trxSurvey value
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.casualbutton1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selanjutnya',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.pureWhite,
                          fontFamily: 'Outfit'),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_outlined,
                        color: Colors.white),
                  ],
                ),
                ),
              ),
              const SizedBox(height: 16), // Spacing before divider
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16), // Spacing after divider
              const SizedBox(height: 20), // Spacing before buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Di Terima pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.casualbutton1,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Di Terima',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.pureWhite,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Di Tolak pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors
                          .redstatus, // Example red color for rejection
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Di Tolak',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.pureWhite,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
