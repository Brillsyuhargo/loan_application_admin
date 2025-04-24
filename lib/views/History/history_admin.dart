import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/views/SurveyList/home_controller.dart';
import 'package:loan_application_admin/widgets/History/filter_button.dart';
import 'package:loan_application_admin/widgets/searchbar.dart';
import 'package:loan_application_admin/widgets/survey_box.dart';

class HistoryAdmin extends StatefulWidget {
  const HistoryAdmin({super.key});

  @override
  State<HistoryAdmin> createState() => _HistoryAdminState();
}

class _HistoryAdminState extends State<HistoryAdmin> {
  final HomeController _controller = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getHistory(); // Fetch history data
    searchController.addListener(() {
      _controller.filterSearch(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const SizedBox(height: 30),
          CustomSearchBar(
            controller: searchController,
            onChanged: (query) => _controller.filterSearch(query),
          ),
          FilterButtons(
            onFilterSelected: (status) => _controller.filterByStatus(status),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.surveyList.isEmpty) {
                return const Center(
                  child: Text('No history found'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _controller.filteredList.length,
                itemBuilder: (context, index) {
                  final item = _controller.filteredList[index];
                  return SurveyBox(
                    name: item.fullName,
                    date: item.application.trxDate,
                    location: item.village,
                    status: "UNREAD",
                    image: 'assets/images/bg.png',
                    statusColor: _controller.getStatusColor("UNREAD"),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
