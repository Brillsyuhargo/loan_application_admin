import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/approval_controller.dart';
import 'package:loan_application_admin/views/SurveyDetail/detail_survey.dart';
import 'package:loan_application_admin/views/SurveyDetail/iqy_document_controller.dart';
import 'package:loan_application_admin/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_document/detail_card.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/field_readonly.dart';
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
        print("DocumentDetailsPage: trxSurvey=$trxSurvey, cifId=$cifId");
      } else {
        documentController.errorMessage.value =
            'trxSurvey tidak valid atau tidak ditemukan';
        Get.snackbar(
          'Error',
          documentController.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite,
        );
      }
    } else {
      documentController.errorMessage.value = 'Argumen tidak ditemukan';
      Get.snackbar(
        'Error',
        documentController.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.redstatus,
        colorText: AppColors.pureWhite,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.softBlue,
        appBar: CustomAppBar(
          title: 'Detail Dokumen',
        ),
        body: Obx(() {
          if (documentController.isLoading.value) {
            return Stack(
              children: [
                _buildContent(context),
                Container(
                  color: AppColors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.royalBlue),
                    ),
                  ),
                ),
              ],
            );
          }
          if (documentController.errorMessage.value.isNotEmpty) {
            return ErrorWidget(
              errorMessage: documentController.errorMessage.value,
              onRetry: () {
                if (trxSurvey.isNotEmpty) {
                  documentController.fetchDocuments(trxSurvey: trxSurvey);
                }
              },
            );
          }
          return _buildContent(context);
        }),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KTP Section
          SectionCard(
            title: 'KTP',
            child: ImageContainer(
              imageUrl: documentController.ktpImage.value,
              placeholderText: 'KTP Tidak Tersedia',
              onTap: () => documentController
                  .showFullScreenImage(documentController.ktpImage.value),
            ),
          ),
          const SizedBox(height: 24),
          // Agunan Section
          SectionCard(
            title: 'Agunan',
            child: Column(
              children: [
                ImageContainer(
                  imageUrl: documentController.imgAgun.value,
                  placeholderText: 'Foto Tanah Tidak Tersedia',
                  onTap: () => documentController
                      .showFullScreenImage(documentController.imgAgun.value),
                ),
                const SizedBox(height: 12),
                FieldReadonly(
                  label: 'Category Agunan',
                  width: double.infinity,
                  height: 50,
                  value: documentController.id_name.value,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                FieldReadonly(
                  label: 'Deskripsi Agunan',
                  width: double.infinity,
                  height: 50,
                  value: documentController.adddescript.value,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                FieldReadonly(
                  label: 'Taksiran Nilai Jaminan',
                  width: double.infinity,
                  height: 50,
                  value: 'Rp. ${documentController.formatRupiah(documentController.value.value)}',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Document Section
          SectionCard(
            title: 'Dokumen',
            child: Column(
              children: [
                ImageContainer(
                  imageUrl: documentController.imgDoc.value,
                  placeholderText: 'Foto Surat Tidak Tersedia',
                  onTap: () => documentController
                      .showFullScreenImage(documentController.imgDoc.value),
                ),
                const SizedBox(height: 12),
                
                FieldReadonly(
                  label: 'Category Document',
                  width: double.infinity,
                  height: 50,
                  value: documentController.descript.value,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Note Section
          SectionCard(
            title: 'Status Dokumen',
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Status Document:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    documentController.judgment.value.isEmpty
                        ? 'Tidak ada data'
                        : documentController.judgment.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Outfit',
                      color:
                          documentController.judgment.value.contains('APPROVED')
                              ? AppColors.greenstatus
                              : documentController.judgment.value
                                      .contains('DECLINED')
                                  ? AppColors.redstatus
                                  : AppColors.blackLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Catatan: ${documentController.note.value.isNotEmpty ? documentController.note.value : 'Tidak ada catatan'}',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Outfit',
                      color: AppColors.blackLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Approval Buttons
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
                              final note = approveNoteController.text.trim();
                              if (note.isEmpty) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.scale,
                                  title: 'Catatan Kosong',
                                  desc: 'Mohon isi catatan terlebih dahulu.',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.orange,
                                ).show();
                                return;
                              }

                              Get.back();
                              await approvalController.submitDocumentApproval(
                                trxSurvey: trxSurvey,
                                cifId: cifId,
                                judgment: 'APPROVED',
                                note: note,
                              );
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
                              Get.back();
                            },
                            onConfirm: () async {
                              final note = declineNoteController.text.trim();
                              if (note.isEmpty) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.scale,
                                  title: 'Catatan Kosong',
                                  desc: 'Mohon isi catatan terlebih dahulu.',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.orange,
                                ).show();
                                return;
                              }

                              Get.back();
                              await approvalController.submitDocumentApproval(
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
        ],
      ),
    );
  }
}
