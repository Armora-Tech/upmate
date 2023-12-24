import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';
import '../../themes/app_color.dart';

class EmojiSection extends StatelessWidget {
  final controller;
  const EmojiSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: EmojiPicker(
        onEmojiSelected: (category, Emoji emoji) {
          controller.isTextFieldEmpty.value = false;
          controller.update();
        },
        onBackspacePressed: () {},
        textEditingController: controller.textEditingController,
        config: Config(
          columns: 10,
          emojiSizeMax: 25 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.30
                  : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: Colors.white,
          indicatorColor: AppColor.primaryColor,
          iconColor: Colors.grey,
          iconColorSelected: AppColor.primaryColor,
          backspaceColor: AppColor.primaryColor,
          skinToneDialogBgColor: AppColor.primaryColor,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          recentTabBehavior: RecentTabBehavior.RECENT,
          recentsLimit: 28,
          noRecents:  Text(
            'no_recents'.tr,
            style: AppFont.text20.copyWith(color: Colors.black26),
            textAlign: TextAlign.center,
          ), // Needs to be const Widget
          loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
        ),
      ),
    );
  }
}
