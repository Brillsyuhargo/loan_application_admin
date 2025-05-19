import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/views/SurveyDetail/iqy_document_controller.dart';
import 'package:loan_application_admin/widgets/custom_appbar.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/field_readonly.dart';

class DetailDocument extends StatefulWidget {
  const DetailDocument({super.key});

  @override
  State<DetailDocument> createState() => _DetailDocumentState();
}

class _DetailDocumentState extends State<DetailDocument> {
  final IqyDocumentController documentController =
      Get.put(IqyDocumentController());

  @override
  void initState() {
    super.initState();
    final trxSurvey = Get.arguments;
    documentController.fetchDocuments(trxSurvey: trxSurvey.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Explicitly set background to white
      appBar: CustomAppBar(
        title: 'Detail Dokumen',
      ),
      body: Obx(() {
        if (documentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (documentController.errorMessage.value.isNotEmpty) {
          return Center(
              child: Text(documentController.errorMessage.value,
                  style: const TextStyle(color: Colors.red)));
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
                              fit: BoxFit
                                  .fitWidth, // Maintain aspect ratio, fit to width
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
              const SizedBox(height: 16), // Spacing before divider
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16), // Spacing after divider

              // Agunan Section
              Center(
                child: const Text(
                  'AGUNAN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Foto Tanah Section
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () => documentController
                      .showFullScreenImage(documentController.fotoTanah.value),
                  child: Container(
                    width: 317,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: documentController.fotoTanah.value.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              documentController.fotoTanah.value,
                              fit: BoxFit
                                  .cover, // Maintain aspect ratio, cover the container
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
              const SizedBox(height: 16), // Spacing before divider
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16), // Spacing after divider

              // BPKB Section
              Center(
                child: const Text(
                  'DOCUMENT',
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
                      .showFullScreenImage(documentController.fotoSurat.value),
                  child: Container(
                    width: 317,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: documentController.fotoSurat.value.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              documentController.fotoSurat.value,
                              fit: BoxFit
                                  .cover, // Maintain aspect ratio, cover the container
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
                      // Add logic for "Di Terima" (e.g., update status, navigate)
                      print('Di Terima pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.casualbutton1,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
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
                      // Add logic for "Di Tolak" (e.g., update status, navigate)
                      print('Di Tolak pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redstatus, // Example red color for rejection
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
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
        );
      }),
    );
  }
}
