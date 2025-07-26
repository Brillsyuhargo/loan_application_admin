import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/approval_controller.dart';
import 'package:loan_application_admin/views/SurveyDetail/iqy_document_controller.dart';
import 'package:loan_application_admin/widgets/custom_appbar.dart';

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

              Get.dialog(
                AlertDialog(
                  title: const Text('Konfirmasi Persetujuan'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Apakah Anda yakin ingin menyetujui dokumen ini?'),
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
                        final note = approveNoteController.text.trim();
                        Get.back();
                        try {
                          await approvalController.submitDocumentApproval(
                            trxSurvey: trxSurvey,
                            cifId: cifId,
                            judgment: 'APPROVED',
                            note: note,
                          );
                          documentController.fetchDocuments(trxSurvey: trxSurvey);
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
                          Get.snackbar('Error', 'Gagal submit approval: $e');
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
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
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

              Get.dialog(
                AlertDialog(
                  title: const Text('Konfirmasi Penolakan'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Apakah Anda yakin ingin menolak dokumen ini?'),
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
                        final note = declineNoteController.text.trim();
                        Get.back();
                        try {
                          await approvalController.submitDocumentApproval(
                            trxSurvey: trxSurvey,
                            cifId: cifId,
                            judgment: 'DECLINED',
                            note: note,
                          );
                          documentController.fetchDocuments(trxSurvey: trxSurvey);
                          Get.snackbar(
                            'Sukses',
                            'Dokumen telah ditolak',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } catch (e) {
                          Get.snackbar('Error', 'Gagal submit penolakan: $e');
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
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
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
                const Icon(Icons.close_outlined, color: Colors.white),
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
