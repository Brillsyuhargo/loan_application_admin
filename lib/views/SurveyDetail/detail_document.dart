import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/approval_controller.dart';
import 'package:loan_application_admin/views/SurveyDetail/iqy_document_controller.dart';
import 'package:loan_application_admin/widgets/custom_appbar.dart';

// Custom Dialog Widget - sama seperti sebelumnya
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

class DetailDocument extends StatefulWidget {
  const DetailDocument({super.key});

  @override
  State<DetailDocument> createState() => _DetailDocumentState();
}

class _DetailDocumentState extends State<DetailDocument> {
  final IqyDocumentController documentController =
      Get.put(IqyDocumentController());
  final ApprovalController approvalController = Get.put(ApprovalController());
  late String trxSurvey;
  late String cifId;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      trxSurvey = arguments['trxSurvey']?.toString() ?? '';
      cifId = arguments['cifId']?.toString() ?? '';

      if (trxSurvey.isNotEmpty) {
        documentController.fetchDocuments(trxSurvey: trxSurvey);
        print("DetailDocument: trxSurvey=$trxSurvey, cifId=$cifId");
      } else {
        documentController.errorMessage.value =
            'trxSurvey tidak valid atau tidak ditemukan';
        Get.snackbar(
          'Error',
          documentController.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      documentController.errorMessage.value = 'Argumen tidak ditemukan';
      Get.snackbar(
        'Error',
        documentController.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Detail Dokumen',
      ),
      body: Obx(() {
        if (documentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (documentController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  documentController.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (trxSurvey.isNotEmpty) {
                      documentController.fetchDocuments(trxSurvey: trxSurvey);
                    }
                  },
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KTP Section
              const Center(
                child: Text(
                  'KTP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () => documentController
                      .showFullScreenImage(documentController.ktpImage.value),
                  child: Container(
                    width: 317,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: documentController.ktpImage.value.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              documentController.ktpImage.value,
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Text(
                                  'KTP Tidak Tersedia',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'KTP Tidak Tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 16),

              // Agunan Section
              const Center(
                child: Text(
                  'AGUNAN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => documentController
                      .showFullScreenImage(documentController.imgAgun.value),
                  child: Container(
                    width: 317,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: documentController.imgAgun.value.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              documentController.imgAgun.value,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Text(
                                  'Foto Tanah Tidak Tersedia',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Foto Tanah Tidak Tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 16),

              // Document Section
              const Center(
                child: Text(
                  'DOKUMEN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => documentController
                      .showFullScreenImage(documentController.imgDoc.value),
                  child: Container(
                    width: 317,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: documentController.imgDoc.value.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              documentController.imgDoc.value,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Text(
                                  'Foto Surat Tidak Tersedia',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Foto Surat Tidak Tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1, color: Colors.grey),
              Obx(() => Center(
                    child: Row(
                      children: [
                        Text("Status Document: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          documentController.judgment.value.isEmpty
                              ? 'Tidak ada data'
                              : documentController.judgment.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: documentController.judgment.value
                                    .contains('APPROVED')
                                ? Colors.green
                                : documentController.judgment.value
                                        .contains('DECLINED')
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
              Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 16),
              Obx(() => approvalController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol "Di Setujui"
                        ElevatedButton(
                          onPressed: () {
                            final TextEditingController approveNoteController =
                                TextEditingController();

                            showDialog(
                              context: context,
                              builder: (context) => CustomApprovalDialog(
                                title: 'Konfirmasi Persetujuan',
                                message:
                                    'Apakah Anda yakin ingin menyetujui dokumen ini?',
                                labelText: 'Catatan Persetujuan',
                                buttonColor: AppColors.casualbutton1,
                                buttonText: 'Ya, Setujui',
                                buttonIcon: Icons.check,
                                noteController: approveNoteController,
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onConfirm: () async {
                                  final note =
                                      approveNoteController.text.trim();
                                  Navigator.of(context).pop();
                                  try {
                                    await approvalController
                                        .submitDocumentApproval(
                                      trxSurvey: trxSurvey,
                                      cifId: cifId,
                                      judgment: 'APPROVED',
                                      note: note,
                                    );
                                    documentController.fetchDocuments(
                                        trxSurvey: trxSurvey);
                                    Get.snackbar(
                                      'Sukses',
                                      'Dokumen telah disetujui',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                    );
                                    Get.toNamed(
                                      MyAppRoutes.detailsurvey,
                                      arguments: {
                                        'trxSurvey': trxSurvey,
                                        'cifId': cifId,
                                      },
                                    );
                                  } catch (e) {
                                    Get.snackbar(
                                        'Error', 'Gagal submit approval: $e');
                                  }
                                },
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
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.check, color: Colors.white),
                            ],
                          ),
                        ),

                        // Tombol "Di Tolak"
                        ElevatedButton(
                          onPressed: () {
                            final TextEditingController declineNoteController =
                                TextEditingController();

                            showDialog(
                              context: context,
                              builder: (context) => CustomApprovalDialog(
                                title: 'Konfirmasi Penolakan',
                                message:
                                    'Apakah Anda yakin ingin menolak dokumen ini?',
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
                                  Navigator.of(context).pop();
                                  try {
                                    await approvalController
                                        .submitDocumentApproval(
                                      trxSurvey: trxSurvey,
                                      cifId: cifId,
                                      judgment: 'DECLINED',
                                      note: note,
                                    );
                                    documentController.fetchDocuments(
                                        trxSurvey: trxSurvey);
                                    Get.snackbar(
                                      'Sukses',
                                      'Dokumen telah ditolak',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  } catch (e) {
                                    Get.snackbar(
                                        'Error', 'Gagal submit penolakan: $e');
                                  }
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
                                  fontFamily: 'Outfit',
                                ),
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
        );
      }),
    );
  }
}
