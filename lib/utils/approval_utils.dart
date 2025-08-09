// lib/utils/approval_utils.dart
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:loan_application_admin/core/theme/color.dart';

void showApprovalDialog({
  required BuildContext context,
  required String responseCode,
  required String? responseMessage,
  String? status,
  VoidCallback? onOk, // ⬅️ Tambahkan parameter ini
}) {
  DialogType dialogType = DialogType.info;
  String title = 'Info';
  String desc = responseMessage ?? 'Unknown response';
  Color btnOkColor = AppColors.greenstatus;

  if (responseCode == '00') {
    dialogType = DialogType.success;
    title = 'Success';
    desc = 'Completed successfully';
    btnOkColor = AppColors.greenstatus;
  } else if (responseCode == '01' && status == 'SERVICELEVEL') {
    dialogType = DialogType.warning;
    title = 'Warning';
    desc = 'Ask for Superior Approval';
    btnOkColor = Colors.orange;
  } else if (responseCode == '04') {
    dialogType = DialogType.error;
    title = 'Error';
    desc = 'The transaction has been closed';
    btnOkColor = AppColors.redstatus;
  } else if (responseCode == '05') {
    dialogType = DialogType.error;
    title = 'Gagal';
    desc = 'Mohon maaf Anda diluar wewenang';
    btnOkColor = AppColors.redstatus;
  } else if (responseCode == '06') {
    dialogType = DialogType.error;
    title = 'Gagal';
    desc = responseMessage ?? 'Anda harus menyetujui document terlebih dahulu';
    btnOkColor = AppColors.redstatus;
  }

  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.scale,
    title: title,
    desc: desc,
    btnOkOnPress: onOk ?? () {}, // ⬅️ Gunakan onOk jika ada
    btnOkColor: btnOkColor,
  ).show();
}

