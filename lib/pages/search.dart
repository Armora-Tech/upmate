import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/search_controller.dart';
import 'package:upmatev2/widgets/global/search_template.dart';
import 'package:upmatev2/widgets/global/user_list.dart';

import '../widgets/global/users_shimmer.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchViewController>();
    return GetBuilder<SearchViewController>(
      builder: (_) => SearchTemplate(
          title: "search".tr,
          controller: controller,
          child: controller.isLoading.value
              ? const UsersShimmer()
              : UserList(selectedPage: SearchPage.searchPage, controller: controller)),
    );
  }
}
