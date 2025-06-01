import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class UserProfilePage extends StatelessWidget {
  final String email = 'aymanhaniadas28@gmail.com';
  final String username = 'ayman28';
  final int age = 21;
  final String gender = 'Male';

  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
        backgroundColor: ColorsTheme.primryButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: screenWidth < 500 ? double.infinity : 400,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorsTheme.secondryButton,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [const BoxShadow(blurRadius: 8, color: Colors.black26)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_circle, size: 80, color: ColorsTheme.primryButton),
                const SizedBox(height: 16),
                _buildInfoTile('Email', email),
                _buildInfoTile('Username', username),
                _buildInfoTile('Age', '$age'),
                _buildInfoTile('Gender', gender),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
