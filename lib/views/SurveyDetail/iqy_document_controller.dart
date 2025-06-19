import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/API/Service/post_inqury_survey.dart';
import 'package:loan_application_admin/API/models/inqury_survey_models.dart';

class IqyDocumentController extends GetxController {
  var ktpImage = ''.obs;
  var imgDoc = ''.obs;
  var imgAgun = ''.obs;
  var agunan = ''.obs;
  var asset = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var adddescript = ''.obs;
  var documentModel = Rxn<Document>();
  var collaborationItems = <CollaborationItem>[].obs;
  var judgment = ''.obs; // Variabel untuk menyimpan judgment

  void fetchDocuments({required String trxSurvey}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquryService = PostInqury();

    try {
      final inquryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );

      documentModel.value = inquryResponse.document;

      ktpImage.value = documentModel.value?.docPerson.isNotEmpty ?? false
          ? documentModel.value!.docPerson[0].img
          : '';
      imgDoc.value = documentModel.value?.docAsset.isNotEmpty ?? false
          ? documentModel.value!.docAsset[0].img
          : '';
      imgAgun.value = documentModel.value?.docImg.isNotEmpty ?? false
          ? documentModel.value!.docImg[0].img
          : '';

      agunan.value = documentModel.value?.docAsset.isNotEmpty ?? false
          ? documentModel.value!.docAsset[0].doc
          : 'Tidak tersedia';
      asset.value = documentModel.value?.docImg.isNotEmpty ?? false
          ? documentModel.value!.docImg[0].doc
          : 'Tidak tersedia';

      collaborationItems.assignAll(inquryResponse.collaboration.items);
      // Filter item dengan Content: "DOC"
      final selectedItem = collaborationItems.firstWhere(
        (item) => item.content == 'DOC',
        orElse: () => CollaborationItem(
          approvalNo: '',
          category: '',
          content: '',
          judgment: 'UNKNOWN',
          date: '',
        ),
      );
      judgment.value =
          selectedItem.judgment; // Simpan judgment (misalnya, "DECLINED-05323")

      print('Selected Judgment: ${judgment.value}');
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data dokumen: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void showFullScreenImage(String imageUrl) {
    if (imageUrl.isEmpty) return;
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Stack(
          children: [
            InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(0),
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Text(
                      'Gagal memuat gambar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 25,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
