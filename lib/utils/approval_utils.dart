// lib/utils/approval_utils.dart
import 'package:get/get.dart';

void showApprovalSnackbar({
  required String responseCode,
  required String? responseMessage,
  String? status,
}) {
  if (responseCode == '00') {
    Get.snackbar('Success', 'Approval completed successfully');
  } else if (responseCode == '01' && status == 'SERVICELEVEL') {
    Get.snackbar('Warning', 'Ask for Superior Approval');
  } else if (responseCode == '04') {
    Get.snackbar('Error', 'The transaction has been closed');
  } else if (responseCode == '05') {
    Get.snackbar('Error', 'Anda diluar wewenang');
  } else {
    Get.snackbar('Info Mase', responseMessage ?? 'Unknown response');
  }
}
