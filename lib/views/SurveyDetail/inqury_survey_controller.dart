import 'package:flutter/material.dart';
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
  var installment = ''.obs;
  var inquiryModel = Rxn<InquirySurveyModel>();
  var collateralProofs = <CollateralProofModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  

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

    } catch (e) {
      errorMessage.value = 'Gagal mengambil data: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}