import 'package:get/get.dart';
import 'package:loan_application_admin/API/service/post_approval.dart';
import 'package:loan_application_admin/utils/approval_utils.dart';

class ApprovalController extends GetxController {
  final ApprovalService _approvalService = ApprovalService();
  var isLoading = false.obs;

  Future<void> submitPlafonApproval({
    required String trxSurvey,
    required String cifId,
    required String judgment,
  }) async {
    try {
      isLoading.value = true;
      final cifIdInt = int.tryParse(cifId);
      if (cifIdInt == null) {
        Get.snackbar('Error', 'Invalid CIF ID');
        return;
      }

      final result = await _approvalService.submitApproval(
        trxSurvey: trxSurvey,
        cifId: cifIdInt,
        content: 'PLAF',
        judgment: judgment,
        token: '396108',
      );

      showApprovalSnackbar(
        responseCode: result.responseCode ?? '',
        responseMessage: result.responseMessage,
        status: result.additionalInfo?.status,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitDocumentApproval({
    required String trxSurvey,
    required String cifId,
    required String judgment,
  }) async {
    try {
      isLoading.value = true;
      final cifIdInt = int.tryParse(cifId);
      if (cifIdInt == null) {
        Get.snackbar('Error', 'Invalid CIF ID');
        return;
      }

      final result = await _approvalService.submitApproval(
        trxSurvey: trxSurvey,
        cifId: cifIdInt,
        content: 'DOC',
        judgment: judgment,
        token: '396108',
      );

      showApprovalSnackbar(
        responseCode: result.responseCode ?? '',
        responseMessage: result.responseMessage,
        status: result.additionalInfo?.status,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
