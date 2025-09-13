import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/controllers/chatbot_controller.dart';

class ChatbotScreen extends StatelessWidget {
  ChatbotScreen({super.key});
  final controller = Get.find<ChatBotController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Ensure Text doesn't overflow
                  child: Text(
                    'WorkForce ChatBot',
                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.toggleChat();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Column(
              children: [
                Center(
                  child: Text('Chat content goes here'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
