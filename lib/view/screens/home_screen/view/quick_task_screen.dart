import 'package:flutter/material.dart';

class QuickTaskNotification extends StatelessWidget {
  const QuickTaskNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 24),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: RichText(
              text: const TextSpan(
                text: '2 ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: 'tasks are waiting for you in ',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  TextSpan(
                    text: 'Tasks',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),

          TextButton(
            onPressed: () {
            
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Open", style: TextStyle(color: Colors.blue)),
          ),

          
        ],
      ),
    );
  }
}
