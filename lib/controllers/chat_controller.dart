import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/start_controller.dart';
import 'package:upmatev2/models/chat_model.dart';
import 'package:upmatev2/models/user_model.dart';
import 'package:upmatev2/repositories/chat_repository.dart';

class ChatController extends GetxController {
  late final StartController _startController;
  List<ChatModel> chats = [];
  List<UserModel> contacts = [];
  ChatModel? selectedChat;
  UserModel? selectedContactChat;
  RxBool isLoading = false.obs;
  RxBool isShowSearch = false.obs;
   late final Stream<QuerySnapshot<Object?>> chatStream;

  @override
  Future<void> onInit() async {
    _startController = Get.find<StartController>();
    await _getChats();
    chatStream =  ChatRepository().getChatsStream();
    super.onInit();
  }

  Future<void> createChat() async {
    isLoading.value = true;
    ChatModel chatModel = ChatModel(
        ref: FirebaseFirestore.instance.collection("chats").doc(),
        lastMessage: "",
        lastMessageTime: DateTime.now(),
        usersRaw: [
          _startController.user!.ref as DocumentReference<Map<String, dynamic>>,
          selectedContactChat!.ref as DocumentReference<Map<String, dynamic>>
        ]);
    await ChatRepository().createChat(chatModel);
    chats = await ChatRepository().getChats();
    isLoading.value = false;
    update();
  }

  Future<void> _getChats() async {
    isLoading.value = true;
    chats = await ChatRepository().getChats();
    contacts = await ChatRepository().getContact();
    isLoading.value = false;
    update();
  }
}
