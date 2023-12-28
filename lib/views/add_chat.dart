import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:upmatev2/widgets/global/search_template.dart';

class AddChatView extends StatelessWidget {
  const AddChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchTemplate(
      title: "create_a_new_chat".tr,
    );
  }
}
