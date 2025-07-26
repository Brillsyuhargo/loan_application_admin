import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application_admin/views/SurveyDetail/approval_controller.dart';
import 'package:loan_application_admin/views/home/home_controller.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_NominalPinjaman.dart';
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
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Obx(() => Center(
                    child: Row(
                      children: [
                        Text("Status Plafond: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          inquryController.plafondJudgment.value.isEmpty
                              ? 'Tidak ada data'
                              : inquryController.plafondJudgment.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: inquryController.plafondJudgment.value
                                    .contains('APPROVED')
                                ? Colors.green
                                : inquryController.plafondJudgment.value
                                        .contains('DECLINED')
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
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
                        // Tombol Setujui
                        ElevatedButton(
                          onPressed: () {
                            final TextEditingController approveNoteController =
                                TextEditingController();

                            Get.dialog(
                              AlertDialog(
                                title: const Text('Konfirmasi Persetujuan'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        'Apakah Anda yakin ingin menyetujui plafon ini?'),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: approveNoteController,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        labelText: 'Catatan Persetujuan',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final note =
                                          approveNoteController.text.trim();
                                      Get.back();
                                      try {
                                        await approvalController
                                            .submitPlafonApproval(
                                          trxSurvey: trxSurvey,
                                          cifId: cifId,
                                          judgment: 'APPROVED',
                                          note: note,
                                        );
                                        inquryController.getSurveyList(
                                            trxSurvey: trxSurvey);
                                        Get.snackbar(
                                          'Sukses',
                                          'Plafon telah disetujui',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                        );
                                        Get.offAllNamed(MyAppRoutes.dashboard);
                                        final HomeController controller =
                                            Get.find<HomeController>();
                                        controller.getHistory();
                                      } catch (e) {
                                        Get.snackbar('Error',
                                            'Gagal submit approval: $e');
                                      }
                                    },
                                    child: const Text('Ya, Setujui'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.casualbutton1,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Di Setujui',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.pureWhite,
                                    fontFamily: 'Outfit'),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.check, color: Colors.white),
                            ],
                          ),
                        ),

                        // Tombol Tolak
                        ElevatedButton(
                          onPressed: () {
                            final TextEditingController declineNoteController =
                                TextEditingController();

                            Get.dialog(
                              AlertDialog(
                                title: const Text('Konfirmasi Penolakan'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        'Apakah Anda yakin ingin menolak plafon ini?'),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: declineNoteController,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        labelText: 'Catatan Penolakan',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final note =
                                          declineNoteController.text.trim();
                                      Get.back();
                                      try {
                                        await approvalController
                                            .submitPlafonApproval(
                                          trxSurvey: trxSurvey,
                                          cifId: cifId,
                                          judgment: 'DECLINED',
                                          note: note,
                                        );
                                        inquryController.getSurveyList(
                                            trxSurvey: trxSurvey);
                                        Get.snackbar(
                                          'Sukses',
                                          'Plafon telah ditolak',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } catch (e) {
                                        Get.snackbar('Error',
                                            'Gagal submit penolakan: $e');
                                      }
                                    },
                                    child: const Text('Ya, Tolak'),
                                  ),
                                ],
                              ),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Di Tolak',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.pureWhite,
                                    fontFamily: 'Outfit'),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.close_outlined,
                                  color: Colors.white),
                            ],
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
