import 'package:get/get.dart';
import 'package:loan_application_admin/API/Service/post_inqury_survey.dart';
import 'package:loan_application_admin/API/models/inqury_survey_models.dart';

class InqurySurveyController extends GetxController {
  var plafond = ''.obs;
  var purpose = ''.obs;
  var adddescript = ''.obs;
  var id_name = ''.obs;
  var value = ''.obs;
  var income = ''.obs;
  var asset = ''.obs;
  var expenses = ''.obs;
  final descript = ''.obs;
  var installment = ''.obs;
  var inquiryModel = Rxn<InquirySurveyModel>();
  var collateralProofs = <CollateralProofModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var plafondJudgment = ''.obs; 
  var note = ''.obs; // Tambahkan variabel untuk menyimpan catatan
  // Tambahkan untuk Content: "PLAF"

  String formatRupiah(String numberString) {
    if (numberString.isEmpty || numberString == '0' || numberString == '0.00') {
      return '0';
    }
    final number =
        double.tryParse(numberString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    if (number == 0) return '0';
    return number.toInt().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
  }

  void getSurveyList({required String trxSurvey}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquryService = PostInqury();

    try {
      final inquryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );

      inquiryModel.value = inquryResponse;
      plafond.value = inquryResponse.application.plafond;
      purpose.value = inquryResponse.application.purpose;
      id_name.value = inquryResponse.collateral.idName;
      adddescript.value = inquryResponse.collateral.adddescript;
      value.value = inquryResponse.collateral.value;
      expenses.value = inquryResponse.additionalInfo.expenses;
      income.value = inquryResponse.additionalInfo.income;
      asset.value = inquryResponse.additionalInfo.asset;
      installment.value = inquryResponse.additionalInfo.installment;
      descript.value = inquryResponse.collateral.adddescript;

      // Filter item dengan Content: "PLAF"
      final selectedItem = inquryResponse.collaboration.items.firstWhere(
        (item) => item.content == 'PLAF',
        orElse: () => CollaborationItem(
          note: '', // Tambahkan note untuk PLAF
          approvalNo: '',
          category: '',
          content: '',
          judgment: 'UNKNOWN',
          date: '',
        ),
      );
      plafondJudgment.value = selectedItem
          .judgment; // Simpan judgment untuk PLAF (misalnya, "APPROVED-05323")
      note.value = selectedItem.note; // Simpan catatan dari item PLAF

      print('PLAF Judgment: ${plafondJudgment.value}');
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
