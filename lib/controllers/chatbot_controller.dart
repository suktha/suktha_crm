import 'package:get/get.dart';

class ChatBotController extends GetxController {
  var isChatOpen = false.obs;

  void toggleChat() {
    isChatOpen.value = !isChatOpen.value;
  }
}
