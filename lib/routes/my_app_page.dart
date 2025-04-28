import 'package:get/get.dart';
import 'package:loan_application_admin/Login/loginScreen.dart';
import 'package:loan_application_admin/navbar/admin/dashboard_page_admin.dart';
import 'package:loan_application_admin/routes/my_app_route.dart';
import 'package:loan_application_admin/splash_screen.dart';
import 'package:loan_application_admin/views/SurveyList/detail.dart';
import 'package:loan_application_admin/views/home/surveylisy_admin.dart';

class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyAppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyAppRoutes.dashboard, page: () => DashboardPageAdmin()),
    GetPage(name: MyAppRoutes.homeScreen, page: () => SurveyList()),
    GetPage(name: MyAppRoutes.surveyDetail, page: () => SurveyDetail()),
  ];
}
