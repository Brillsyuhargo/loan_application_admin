// lib/utils/approval_utils.dart
import 'package:get/get.dart';
import 'package:loan_application_admin/core/theme/color.dart';

void showApprovalSnackbar({
  required String responseCode,
  required String? responseMessage,
  String? status,
}) {
  if (responseCode == '00') {
    Get.snackbar('Success', 'Completed successfully',
        backgroundColor: AppColors.greenstatus, colorText: AppColors.pureWhite);
  } else if (responseCode == '01' && status == 'SERVICELEVEL') {
    Get.snackbar('Warning', 'Ask for Superior Approval');
  } else if (responseCode == '04') {
    Get.snackbar('Error', 'The transaction has been closed');
  } else if (responseCode == '05') {
    Get.snackbar('Gagal', 'Mohon maaf Anda diluar wewenang',
        backgroundColor: AppColors.redstatus, colorText: AppColors.pureWhite);
  } else if (responseCode == '06') {
    Get.snackbar('Gagal',
        responseMessage ?? 'Anda harus menyetujui document terlebih dahulu',
        backgroundColor: AppColors.redstatus, colorText: AppColors.pureWhite);
  } else
    Get.snackbar('Berhasil', responseMessage ?? 'Unknown response');
}
