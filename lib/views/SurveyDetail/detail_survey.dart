import 'package:awesome_dialog/awesome_dialog.dart';
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

// Custom Dialog Widget - langsung di file ini
class CustomApprovalDialog extends StatelessWidget {
  final String title;
  final String message;
  final String labelText;
  final Color buttonColor;
  final String buttonText;
  final IconData buttonIcon;
  final TextEditingController noteController;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomApprovalDialog({
    super.key,
    required this.title,
    required this.message,
    required this.labelText,
    required this.buttonColor,
    required this.buttonText,
    required this.buttonIcon,
    required this.noteController,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with icon
            Row(
              children: [
                Icon(
                  buttonIcon,
                  color: buttonColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Message
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Note input field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, color: Colors.black, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Batal',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(buttonIcon, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          buttonText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
                      // FieldReadonly(
                      //   label: 'Category Agunan',
                      //   width: double.infinity,
                      //   height: 50,
                      //   value: inquryController.id_name.value,
                      //   keyboardType: TextInputType.text,
                      // ),
                      // SizedBox(height: 4),
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
                    child: Column(
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
                         const SizedBox(height: 8),
                        Obx(() => Text(
                              'Catatan: ${inquryController.note.value.isNotEmpty ? inquryController.note.value : 'Tidak ada catatan'}',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ),
                            )),
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
                            final approveNoteController =
                                TextEditingController();

                            final validContext =
                                context; // <-- Simpan context valid

                            showDialog(
                              context: context,
                              builder: (context) => CustomApprovalDialog(
                                  title: 'Konfirmasi Persetujuan',
                                  message:
                                      'Apakah Anda yakin ingin menyetujui plafon ini?',
                                  labelText: 'Catatan Persetujuan',
                                  buttonColor: AppColors.casualbutton1,
                                  buttonText: 'Ya, Setujui',
                                  buttonIcon: Icons.check,
                                  noteController: approveNoteController,
                                  onCancel: () {
                                    Get.back();
                                  },
                                  onConfirm: () async {
                                    final note =
                                        approveNoteController.text.trim();
                                    if (note.isEmpty) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        animType: AnimType.scale,
                                        title: 'Catatan Kosong',
                                        desc:
                                            'Mohon isi catatan terlebih dahulu.',
                                        btnOkOnPress: () {},
                                        btnOkColor: Colors.orange,
                                      ).show();
                                      return; // Stop agar tidak lanjut submit
                                    }

                                    Get.back();
                                    await approvalController
                                        .submitPlafonApproval(
                                      trxSurvey: trxSurvey,
                                      cifId: cifId,
                                      judgment: 'APPROVED',
                                      note: note,
                                    );
                                  }),
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

                            showDialog(
                              context: context,
                              builder: (context) => CustomApprovalDialog(
                                title: 'Konfirmasi Penolakan',
                                message:
                                    'Apakah Anda yakin ingin menolak plafon ini?',
                                labelText: 'Catatan Penolakan',
                                buttonColor: AppColors.redstatus,
                                buttonText: 'Ya, Tolak',
                                buttonIcon: Icons.close_outlined,
                                noteController: declineNoteController,
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onConfirm: () async {
                                  final note =
                                      declineNoteController.text.trim();
                                  if (note.isEmpty) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.scale,
                                      title: 'Catatan Kosong',
                                      desc:
                                          'Mohon isi catatan terlebih dahulu.',
                                      btnOkOnPress: () {},
                                      btnOkColor: Colors.orange,
                                    ).show();
                                    return; // Stop agar tidak lanjut submit
                                  }

                                  Get.back();
                                  await approvalController.submitPlafonApproval(
                                    trxSurvey: trxSurvey,
                                    cifId: cifId,
                                    judgment: 'DECLINED',
                                    note: note,
                                  );
                                },
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
