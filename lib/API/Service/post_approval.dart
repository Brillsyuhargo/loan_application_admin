import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/API/dio/dio_client.dart';
import 'package:loan_application_admin/API/models/approval_survey_model.dart';

class ApprovalService {
  final dio = DioClient.dio;

  // Generate custom headers
  Map<String, String> _generateHeaders() {
    final timestamp =
        '${DateTime.now().toUtc().toIso8601String().split('.').first}Z';
    return {
      'ICS-Wipala': 'sastra.astana.dwipangga',
      'ICS-Timestamp': timestamp,
      'ICS-Signature': 'sandbox.rus2025',
      'Content-Type': 'application/json',
    };
  }

  // Submit approval (DOC or PLAF)
  Future<ApprovalSurveyModel> submitApproval({
    required String trxSurvey,
    required int cifId,
    required String content,
    required String judgment,
    String token = '396108',
    String officeId = '000',
    String category = 'SURVEY_DEBT',
  }) async {
    if (content != 'DOC' && content != 'PLAF') {
      throw Exception('Invalid content: Must be DOC or PLAF');
    }

    final body = {
      'Office_ID': officeId,
      'cif_id': cifId,
      'trx_survey': trxSurvey,
      'approval': {
        'category': category,
        'content': content,
        'judgment': judgment,
        'token': token,
      },
    };

    try {
      final response = await dio.post(
        '/sandbox.ics/v1.0/v1/survey/approval',
        data: body,
        options: Options(headers: _generateHeaders()),
      );

      if (response.data is Map<String, dynamic>) {
        final res = response.data as Map<String, dynamic>;
        final code = res['responseCode']?.toString();
        final msg = res['responseMessage']?.toString();

        if (response.statusCode == 200 && code == '00') {
          Get.snackbar('Berhasil', 'Approve sukses',
              backgroundColor: Colors.green, colorText: Colors.white);
        }

        return ApprovalSurveyModel.fromJson(res);
      } else {
        throw Exception(
          'Invalid response format: Expected JSON, received ${response.data.runtimeType}',
        );
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      String responseCode = '';
      String responseMessage = '';

      if (data is Map<String, dynamic>) {
        responseCode = data['responseCode']?.toString() ?? '';
        responseMessage = data['responseMessage']?.toString() ?? '';
      } else if (data is String) {
        // Optional regex fallback for string-based error
        final codeMatch = RegExp(r'responseCode: (\d{2})').firstMatch(data);
        final msgMatch = RegExp(r'responseMessage: ([^,}]+)').firstMatch(data);
        responseCode = codeMatch?.group(1) ?? '';
        responseMessage = msgMatch?.group(1) ?? '';
      }

      if (responseCode == '05') {
        Get.snackbar('Gagal', 'Anda diluar wewenang',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar('Error',
            responseMessage.isNotEmpty ? responseMessage : 'Terjadi kesalahan',
            backgroundColor: Colors.orange, colorText: Colors.white);
      }

      throw Exception(
          'Failed to submit approval bro : ${data ?? e.message} (${e.response?.statusCode})');
    }
  }
}
