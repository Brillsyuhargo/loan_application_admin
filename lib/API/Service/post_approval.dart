import 'package:dio/dio.dart';
import 'package:loan_application_admin/API/dio/dio_client.dart';
import 'package:loan_application_admin/API/models/approval_survey_model.dart';

class ApprovalService {
  final dio = DioClient.dio;

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

  Future<ApprovalSurveyModel> submitApproval({
    required String trxSurvey,
    required int cifId,
    required String content,
    required String judgment,
    required String note,
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
      'note': note,
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
        return ApprovalSurveyModel.fromJson(res);
      } else {
        throw Exception(
          'Invalid response format: Expected JSON, received ${response.data.runtimeType}',
        );
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      final statusCode = e.response?.statusCode;

      // Tangani 401 Unauthorized
      if (statusCode == 401) {
        if (data is Map<String, dynamic>) {
          final responseCode = data['responseCode']?.toString() ?? 'UNKNOWN';
          if (responseCode == '02') {
            return ApprovalSurveyModel(
              responseCode: '02',
              responseMessage: 'Mandatory document attachments are required',
            );
          } else if (responseCode == '06') {
            return ApprovalSurveyModel(
              responseCode: '06',
              responseMessage: 'Document Harus Disetujui Terlebih Dahulu',
            );
          } else {
            return ApprovalSurveyModel(
              responseCode: '05',
              responseMessage: 'Mohon maaf Anda diluar wewenang ',
            );
          }
        }
      }

      // Tangani respons error lainnya
      if (data is Map<String, dynamic>) {
        return ApprovalSurveyModel.fromJson(data);
      } else {
        throw Exception(
          'Failed to submit approval: ${data ?? e.message} ($statusCode)',
        );
      }
    }
  }
}
