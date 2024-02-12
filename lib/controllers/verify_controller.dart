import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import '../repositories/auth.dart';
import '../routes/route_name.dart';
import '../widgets/global/snack_bar.dart';

class VerifyController extends GetxController {
  late final LoginController _loginController;
  late final bool isLogin;
  RxString inputOTP = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    _loginController = Get.find<LoginController>();
    isLogin = Get.arguments ?? false;
    super.onInit();
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    bool isVerified = await Auth().checkOTP(inputOTP.value, isLogin);
    if (isVerified) {
      isLoading.value = false;
      if (_loginController.isNewUser.value) {
        Get.toNamed(RouteName.tagInterest);
      } else {
        Get.offAllNamed(RouteName.start);
      }
    } else {
      isLoading.value = false;
      SnackBarWidget.showSnackBar(false, "otp_verification_failed".tr);
    }
  }
}
