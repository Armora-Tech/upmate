import 'package:get/get.dart';
import 'package:upmatev2/bindings/edit_profile_binding.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/bindings/settings_binding.dart';
import 'package:upmatev2/bindings/signup_binding.dart';
import 'package:upmatev2/bindings/start_binding.dart';
import 'package:upmatev2/bindings/tag_interest_binding.dart';
import 'package:upmatev2/bindings/verify_binding.dart';
import 'package:upmatev2/pages/chat/create_chat_page.dart';
import 'package:upmatev2/pages/chatRoom/chat_room.dart';
import 'package:upmatev2/pages/chatRoom/confirm_send_image_page.dart';
import 'package:upmatev2/pages/editProfile/gallery.dart';
import 'package:upmatev2/pages/createPost/create_post_description_page.dart';
import 'package:upmatev2/pages/createPost/create_post_interest_page.dart';
import 'package:upmatev2/pages/profile.dart';
import 'package:upmatev2/pages/settings.dart';
import '../bindings/chat_room_binding.dart';
import '../bindings/post_binding.dart';
import '../bindings/post_detail_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/search_binding.dart';
import '../pages/createPost/confirm_post_image_page.dart';
import '../pages/editProfile/edit_profile.dart';
import '../pages/login.dart';
import '../pages/createPost/create_post_page.dart';
import '../pages/post_detail.dart';
import '../pages/search.dart';
import '../pages/chat/search_chat_page.dart';
import '../pages/signup.dart';
import '../pages/start_page.dart';
import '../pages/tag_interest_page.dart';
import '../pages/take_survey.dart';
import '../pages/verify_page.dart';
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
        transition: Transition.rightToLeft,
        binding: VerifyBinding()),
    GetPage(
        name: RouteName.takeSurvey,
        page: () => const TakeSurveyView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.tagInterest,
        page: () => const TagInterestView(),
        transition: Transition.rightToLeft,
        binding: TagInterestBinding()),
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
    GetPage(
      name: RouteName.postDetail,
      page: () => const PostDetailView(),
      binding: PostDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteName.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouteName.createChat,
      page: () => const CreateChatView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouteName.searchChat,
      page: () => const SearchChatView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouteName.post,
      page: () => const CreatePostView(),
      binding: PostBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
        name: RouteName.confirmSendImage,
        page: () => const ConfirmSendImageView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.confirmPostImage,
        page: () => const ConfirmPostImageView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.postDescription,
        page: () => const PostDescriptionView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.editProfile,
        page: () => const EditProfileView(),
        binding: EditProfileBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.galleryView,
        page: () => const GalleryView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.postInterest,
        page: () => const CreatePostInterestView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: RouteName.settings,
        page: () => const SettingsView(),
        binding: SettingsBinding(),
        transition: Transition.rightToLeft),
  ];
}
