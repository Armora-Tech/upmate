import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repositories/chat_repository.dart';

class SearchViewController extends GetxController {
  late final TextEditingController searchText;
  late List<UserModel> listSearchResult;
  RxBool isLoading = false.obs;
  RxBool isSearchTextEmpty = true.obs;
  List<UserModel> contacts = [];

  @override
  Future<void> onInit() async {
    searchText = TextEditingController();
    await _getUsers();
    listSearchResult = List.from(contacts);
    super.onInit();
  }

  @override
  void onClose() {
    searchText.dispose();
    super.onClose();
  }

  Future<void> _getUsers() async {
    isLoading.value = true;
    contacts = await ChatRepository().getContact();
    isLoading.value = false;
    update();
  }

  void handleSearch(String text) {
    if (text.isNotEmpty) {
      isSearchTextEmpty.value = false;
    } else {
      isSearchTextEmpty.value = true;
    }
    listSearchResult = contacts
        .where((element) =>
            element.displayName.toLowerCase().contains(text.toLowerCase()))
        .toList();
    update();
  }

  void back() {
    searchText.clear();
    isSearchTextEmpty.value = true;
    listSearchResult = List.from(contacts);
  }
}
