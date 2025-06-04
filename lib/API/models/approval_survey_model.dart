class ApprovalSurveyModel {
  final String responseCode;
  final String responseMessage;
  final AdditionalInfo? additionalInfo;
  final List<Collaboration>? collaboration;
  final Application? application;

  ApprovalSurveyModel({
    required this.responseCode,
    required this.responseMessage,
    this.additionalInfo,
    this.collaboration,
    this.application,
  });

  factory ApprovalSurveyModel.fromJson(Map<String, dynamic> json) {
    return ApprovalSurveyModel(
      responseCode: json['responseCode'] ?? '',
      responseMessage: json['responseMessage'] ?? '',
      additionalInfo: json['additionalInfo'] != null
          ? AdditionalInfo.fromJson(json['additionalInfo'])
          : null,
      collaboration: json['Collaboration'] != null
          ? (json['Collaboration'] as List)
              .map((e) => Collaboration.fromJson(e))
              .toList()
          : null,
      application: json['application'] != null
          ? Application.fromJson(json['application'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseMessage': responseMessage,
      'additionalInfo': additionalInfo?.toJson(),
      'Collaboration': collaboration?.map((e) => e.toJson()).toList(),
      'application': application?.toJson(),
    };
  }
}

class AdditionalInfo {
  final String category;
  final String approvalNo;
  final String status;
  final String message;

  AdditionalInfo({
    required this.category,
    required this.approvalNo,
    required this.status,
    required this.message,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      category: json['category'] ?? '',
      approvalNo: json['approval_no'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'approval_no': approvalNo,
      'status': status,
      'message': message,
    };
  }
}

class Collaboration {
  final String approvalNo;
  final String category;
  final String content;
  final String judgment;
  final String date;

  Collaboration({
    required this.approvalNo,
    required this.category,
    required this.content,
    required this.judgment,
    required this.date,
  });

  factory Collaboration.fromJson(Map<String, dynamic> json) {
    return Collaboration(
      approvalNo: json['Approval_No'] ?? '',
      category: json['Category'] ?? '',
      content: json['Content'] ?? '',
      judgment: json['Judgment'] ?? '',
      date: json['Date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Approval_No': approvalNo,
      'Category': category,
      'Content': content,
      'Judgment': judgment,
      'Date': date,
    };
  }
}

class Application {
  final String applicationNo;
  final String trxSurvey;

  Application({
    required this.applicationNo,
    required this.trxSurvey,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      applicationNo: json['application_no'] ?? '',
      trxSurvey: json['trx_survey'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'application_no': applicationNo,
      'trx_survey': trxSurvey,
    };
  }
}