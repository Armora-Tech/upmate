import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
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
          onEmojiSelected: (category, Emoji emoji) {},
          onBackspacePressed: () {},
          textEditingController:
              controller.textEditingController,
          config: Config(
            columns: 10,
            emojiSizeMax: 25 *
                (foundation.defaultTargetPlatform ==
                        TargetPlatform.iOS
                    ? 1.30
                    : 1.0),
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            initCategory: Category.RECENT,
            bgColor: AppColor.primaryColor,
            indicatorColor: Colors.white,
            iconColor: Colors.grey,
            iconColorSelected: Colors.white,
            backspaceColor: Colors.white,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            recentTabBehavior: RecentTabBehavior.RECENT,
            recentsLimit: 28,
            noRecents: const Text(
              'No Recents',
              style: TextStyle(
                  fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ), // Needs to be const Widget
            loadingIndicator: const SizedBox
                .shrink(), // Needs to be const Widget
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL,
          ),
        ),
      );
  }
}