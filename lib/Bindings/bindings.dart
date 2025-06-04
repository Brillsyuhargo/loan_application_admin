import 'package:get/get.dart';
import 'package:loan_application_admin/Login/controller.dart';
import 'package:loan_application_admin/utils/signature_utils.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllers>(() => LoginControllers(), fenix: true);
    Get.put(SignatureController());

  }
}
