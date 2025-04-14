
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/views/History/history_admin.dart';
import 'package:loan_application_admin/views/Profile/profile_admin.dart';
import 'package:loan_application_admin/views/Simulation_Calculator/simulation_admin.dart';
import 'package:loan_application_admin/views/SurveyList/surveylist_admin.dart';
import 'package:loan_application_admin/controller/admin/controller_page_admin.dart';

import '../../../core/theme/color.dart';

class DashboardPageAdmin extends StatelessWidget {
  const DashboardPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerPageAdmin dashboardController =
        Get.put(ControllerPageAdmin());

    final List<Widget> menus = [
      SurveylistAdmin(),
      HistoryAdmin(),
      SimulationAdmin(),
      ProfileAdmin()
    ];

    return Obx(() {
      return Scaffold(
        body: menus[dashboardController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: dashboardController.selectedIndex.value,
          onTap: (index) {
            dashboardController.selectedIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.lightBlue,
          selectedItemColor: AppColors.pureWhite,
          unselectedItemColor: AppColors.pureWhite.withOpacity(0.6),
          items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'SurveyList',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Simulation',
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            ),
          ]
        )
      );
    });
  }
}

// //BottomNavigationBar(
//           currentIndex: dashboardController.selectedIndex.value,
//           onTap: (index) {
//             dashboardController.selectedIndex.value = index;
//           },
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
//           backgroundColor: Colors.grey[850],
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: "SurveyList",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.bookmark),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.bookmark),
//               label: "Simulation",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: "Profile",
//             ),
//           ],
//         ),
