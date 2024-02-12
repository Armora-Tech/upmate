import 'package:get/get.dart';
import '../repositories/auth.dart';
import '../routes/route_name.dart';
import '../widgets/global/snack_bar.dart';

class VerifyController extends GetxController {
  late final bool isLogin;
  RxString inputOTP = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    isLogin = Get.arguments ?? false;
    super.onInit();
  }

  Future<void> verifyOTP() async {
    isLoading.value = true;
    bool isVerified = await Auth().checkOTP(inputOTP.value, isLogin);
    if (isVerified) {
      isLoading.value = false;
      Get.toNamed(RouteName.tagInterest);
    } else {
      isLoading.value = false;
      SnackBarWidget.showSnackBar(false, "otp_verification_failed".tr);
    }
  }
}
