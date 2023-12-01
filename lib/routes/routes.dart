import 'package:get/get.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/bindings/signup_binding.dart';
import '../views/login.dart';
import '../views/signup.dart';
import 'route_name.dart';

class AppPage {
  static final pages = [
    GetPage(
        name: RouteName.loginView,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: RouteName.signupView,
        page: () => const SignupView(),
        binding: SignupBinding()),
  ];
}
