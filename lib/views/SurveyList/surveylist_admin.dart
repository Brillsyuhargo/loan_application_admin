import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/views/SurveyList/surveylist_controller.dart';
import 'package:loan_application_admin/widgets/survey_box.dart';

class SurveylistAdmin extends StatefulWidget {
  const SurveylistAdmin({super.key});

  @override
  State<SurveylistAdmin> createState() => _SurveylistAdminState();
}

class _SurveylistAdminState extends State<SurveylistAdmin> {
  final SurvelistController controller = Get.put(SurvelistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 57,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Survey List',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: controller.surveyList.length,
                  itemBuilder: (context, index) {
                    final item = controller.surveyList[index];
                    return SurveyBox(
                      name: item['name']!,
                      date: item['date']!,
                      location: item['location']!,
                      status: item['status']!,
                      image: item['image']!,
                      statusColor: controller.getStatusColor(item['status']!),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
