import 'package:flutter/material.dart';

class QuickTaskNotification extends StatelessWidget {
  const QuickTaskNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Row(
        children: [
          // ✅ Purple Icon
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check, color: Colors.white, size: 24),
          ),

          SizedBox(width: 12),

          // ✅ Text Section
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '1 ',
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
                    text: 'Quick Tasks',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Open Button
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("Open", style: TextStyle(color: Colors.blue)),
          ),

          // ✅ 3-dot Menu
          SizedBox(width: 6),
          Icon(Icons.more_vert, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
