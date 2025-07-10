import 'package:flutter/material.dart';

class AdminProfileCard extends StatelessWidget {
  final String adminName;
  final String role;
  final String profileImageUrl;

  const AdminProfileCard({
    super.key,
    required this.adminName,
    required this.role,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:const Color.fromARGB(157, 225, 245, 254) ,
        borderRadius: BorderRadius.circular(16),
      
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(profileImageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adminName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color:  Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey[700]),
            onPressed: () {
              // Navigate to admin settings
            },
          ),
        ],
      ),
    );
  }
}
