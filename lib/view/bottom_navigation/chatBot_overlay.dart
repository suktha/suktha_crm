import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/controllers/chatbot_controller.dart';

class ChatBotOverlay {
  static final ChatBotOverlay _instance = ChatBotOverlay._internal();
  factory ChatBotOverlay() => _instance;
  ChatBotOverlay._internal();

  OverlayEntry? _overlayEntry;
  final ChatBotController controller = Get.find();

  void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        right: 20,
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                controller.isChatOpen.value
                    ? Container(
                        width: 90.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      // Ensure Text doesn't overflow
                                      child: Text(
                                        'WorkForce ChatBot',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.sp),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.toggleChat();
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        'Chat content goes here',
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    controller.toggleChat();
                  },
                  child: controller.isChatOpen.value
                      ? const Icon(Icons.close)
                      : Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.shutterstock.com/image-vector/chat-bot-icon-virtual-smart-600nw-2478937553.jpg"))),
                        ),
                  // child: Icon(controller.isChatOpen.value
                  //     ? Icons.close
                  //     : Icons.chat_bubble),
                ),
              ],
            )),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
