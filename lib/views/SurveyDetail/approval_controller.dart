import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/API/Service/post_approval.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/approval_utils.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';

class ApprovalController extends GetxController {
  final ApprovalService _approvalService = ApprovalService();
  var isLoading = false.obs;

  Future<void> submitPlafonApproval({
    required String trxSurvey,
    required String cifId,
    required String judgment,
    required String note,
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
        note: note,
      );

      if (result.responseCode == '00') {
        // sukses
        await Future.delayed(Duration(
            milliseconds: 200)); // opsional, supaya aman sebelum page pindah
        showApprovalDialog(
          context: Get.context!,
          responseCode: result.responseCode!,
          responseMessage: result.responseMessage,
          status: result.additionalInfo?.status,
          onOk: () {
            Get.offAllNamed(MyAppRoutes.dashboard); // pindah ke halaman home
          },
        );
      } else {
        // gagal
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Gagal',
          desc: result.responseMessage ?? 'Terjadi kesalahan.',
          btnOkOnPress: () {},
          btnOkColor: AppColors.redstatus,
        ).show();
      }
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
    required String note,
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
        note: note,
      );

      showApprovalDialog(
        context: Get.context!,
        responseCode: result.responseCode ?? '',
        responseMessage: result.responseMessage,
        status: result.additionalInfo?.status,
        onOk: () {
          // navigasi ke plafon setelah OK ditekan
          Get.toNamed(
            MyAppRoutes.detailsurvey,
            arguments: {
              'trxSurvey': trxSurvey,
              'cifId': cifId,
            },
          );
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
