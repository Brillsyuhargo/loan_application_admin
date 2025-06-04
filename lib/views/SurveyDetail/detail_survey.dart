import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application_admin/views/SurveyDetail/approval_controller.dart';
import 'package:loan_application_admin/views/home/home_controller.dart';
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
  final ApprovalController approvalController = Get.put(ApprovalController());
  late String trxSurvey;
  late String cifId;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    trxSurvey = arguments['trxSurvey']?.toString() ?? '';
    cifId = arguments['cifId']?.toString() ?? '';
    print("DetailSurvey: trxSurvey=$trxSurvey, cifId=$cifId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inquryController.getSurveyList(trxSurvey: trxSurvey);
    });
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
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Loan_angkaPinjaman(),
                    ],
                  )),
              const SizedBox(height: 16),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Obx(() => approvalController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await approvalController.submitPlafonApproval(
                                trxSurvey: trxSurvey,
                                cifId: cifId,
                                judgment: 'APPROVED',
                              );
                              Get.offAllNamed(MyAppRoutes
                                  .dashboard); // Navigasi ke dashboard, hapus stack sebelumnya
                              final HomeController controller = Get.find<
                                  HomeController>(); // Gunakan controller yang sudah ada
                              controller.getHistory(); // Refresh survey list
                            } catch (e) {
                              Get.snackbar(
                                  'Error', 'Gagal submit approval: $e');
                            }
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
                            approvalController.submitPlafonApproval(
                              trxSurvey: trxSurvey,
                              cifId: cifId,
                              judgment: 'DECLINED',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redstatus,
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
                    )),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
