import 'package:get/get.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/bindings/signup_binding.dart';
import 'package:upmatev2/bindings/start_binding.dart';
import 'package:upmatev2/views/chat_room.dart';
import 'package:upmatev2/views/profile.dart';
import '../bindings/chat_room_binding.dart';
import '../bindings/profile_binding.dart';
import '../views/login.dart';
import '../views/signup.dart';
import '../views/start.dart';
import '../views/tag_interest.dart';
import '../views/take_survey.dart';
import '../views/verify.dart';
import 'route_name.dart';

class AppPage {
  static final pages = [
    GetPage(
        name: RouteName.login,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: RouteName.signup,
        page: () => const SignupView(),
        binding: SignupBinding()),
    GetPage(
        name: RouteName.verify,
        page: () => const VerifyView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.takeSurvey,
        page: () => const TakeSurveyView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.tagInterest,
        page: () => const TagInterestView(),
        transition: Transition.rightToLeft),
    GetPage(
      name: RouteName.start,
      page: () => const StartView(),
      binding: StartBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteName.chatRoom,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteName.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
