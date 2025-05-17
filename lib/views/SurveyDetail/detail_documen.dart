import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_NominalPinjaman.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_bukti_agunan.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/detail_nilaiPinjaman.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/field_readonly.dart';
import 'package:loan_application_admin/widgets/custom_appbar.dart';

class DetailDocumen extends StatefulWidget {
  const DetailDocumen({super.key});

  @override
  State<DetailDocumen> createState() => _DetailDocumenState();
}

class _DetailDocumenState extends State<DetailDocumen> {
  final InqurySurveyController inquryController =
      Get.put(InqurySurveyController());

  @override
  void initState() {
    super.initState();
    final trxSurvey = Get.arguments;
    inquryController.getSurveyList(trxSurvey: trxSurvey.toString());
    print("trx survey: $trxSurvey");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Detail Documen',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Category_agunan(),
              SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldReadonly(
                        label: 'Tujuan Pinjaman',
                        width: double.infinity,
                        height: 50,
                        value: inquryController.purpose.value,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 4),
                      FieldReadonly(
                        label: 'Deskripsi Pinjaman',
                        width: double.infinity,
                        height: 50,
                        value: inquryController.adddescript.value,
                        keyboardType: TextInputType.text,
                      ),
                      Loan_angkaPinjaman(),
                      NilaiPinjaman(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}