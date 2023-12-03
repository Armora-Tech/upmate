import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  late TextEditingController textEditingController;
  RxBool isTextFieldEmpty = true.obs;
  RxDouble defaultRadius = 20.0.obs;
  RxDouble taperRadius = 3.0.obs;
  RxDouble marginTop = 0.0.obs;
  RxDouble marginBottom = 0.0.obs;

  List<Map<String, String>> chats = [
    {"user": "Hallo bang"},
    {"other": "Apa kabar?"},
    {"user": "Baik kah bang asiiaapp baik kah bang"},
    {"user": "Baik kah bang asiiaapp"},
    {
      "user":
          "Baik kah bang asiiaapp baik kah bang asiiaapp baik kah bang asiap"
    },
    {"other": "Baik kah bang asiiaapp"},
    {
      "other":
          "Baik kah bang asiiaapp baik kah bang asiiaapp baik kah bang asiap"
    },
    {"user": "Baik kah bang asiiaapp"},
    {
      "other":
          "Baik kah bang asiiaapp baik kah bang asiiaapp baik kah bang asiap"
    },
    {"user": "Baik kah bang asiiaapp"},
    {
      "user":
          "Baik kah bang asiiaapp baik kah bang asiiaapp baik kah bang asiap"
    },
    {"other": "Baik kah bang asiiaapp"},
    {"other": "Baik kah bang asiiaapp"},
    {"other": "Baik kah bang asiiaapp"},
    {"other": "Baik kah bang asiiaapp"},
  ];

// cek apakah user yang mengirimkan chat?
  bool isUser(int index) {
    return chats[index].keys.first == "user";
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan bawah pada chat user
  BorderRadius initialUserChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(taperRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan atas pada chat user
  BorderRadius finalUserChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(taperRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kiri bawah pada chat lawannya
  BorderRadius initialOtherChatBorder() {
    return BorderRadius.only(
        topLeft: Radius.circular(defaultRadius.value),
        topRight: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(taperRadius.value));
  }

// function yang mengembalikan border radius yang
// lancip pada bagian kanan bawah pada chat lawannya
  BorderRadius finalOtherChatBorder() {
    return BorderRadius.only(
        topRight: Radius.circular(defaultRadius.value),
        bottomLeft: Radius.circular(defaultRadius.value),
        bottomRight: Radius.circular(defaultRadius.value),
        topLeft: Radius.circular(taperRadius.value));
  }

// function untuk mengatur margin antara chat user dan lawannya
  void setMargin(int index) {
    // chatnya user
    if (isUser(index)) {
      if (index == 0) {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
      // kalau sebelumnya chat lawan
      else if (index != 0 && !isUser(index - 1)) {
        marginTop.value = 10;
        marginBottom.value = 0;
      }
      // kalau setelahnya chat lawan
      else if (index != chats.length - 1 && !isUser(index + 1)) {
        marginBottom.value = 10;
        marginTop.value = 0;
      }
      // kalau chat sebelumnya dan setelahnya masih chatnya user
      else {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
    }
    // chatnya lawannya
    else {
      // chat paling atas
      if (index == 0) {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
      // kalau sebelumnya chat user
      else if (index != 0 && isUser(index - 1)) {
        marginTop.value = 10;
        marginBottom.value = 0;
      }
      // bawah beda
      else if (index != chats.length - 1 && isUser(index + 1)) {
        marginBottom.value = 10;
        marginTop.value = 0;
      }
      // kalau chat sebelumnya dan setelahnya masih chatnya lawan
      else {
        marginTop.value = 0;
        marginBottom.value = 0;
      }
    }
  }

// function untuk mengatur border radius border chatnya
  BorderRadius checkPositionedUserChat(int index) {
    // konsepnya sama seperti yang diatas bedanya dia ngereturn borderRadius
    if (isUser(index)) {
      if (index == 0) {
        return initialUserChatBorder();
      } else if (index == chats.length - 1) {
        return finalUserChatBorder();
      } else if (index != 0 && !isUser(index - 1)) {
        return initialUserChatBorder();
      } else if (index != chats.length - 1 && !isUser(index + 1)) {
        return finalUserChatBorder();
      } else {
        return BorderRadius.only(
            bottomLeft: Radius.circular(defaultRadius.value),
            topLeft: Radius.circular(defaultRadius.value),
            topRight: Radius.circular(taperRadius.value),
            bottomRight: Radius.circular(taperRadius.value));
      }
    } else {
      if (index == 0) {
        return initialOtherChatBorder();
      } else if (index == chats.length - 1) {
        return finalOtherChatBorder();
      } else if (index != 0 && isUser(index - 1)) {
        return initialOtherChatBorder();
      } else if (index != chats.length - 1 && isUser(index + 1)) {
        return finalOtherChatBorder();
      } else {
        return BorderRadius.only(
            topLeft: Radius.circular(taperRadius.value),
            bottomLeft: Radius.circular(taperRadius.value),
            bottomRight: Radius.circular(defaultRadius.value),
            topRight: Radius.circular(defaultRadius.value));
      }
    }
  }

  @override
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
