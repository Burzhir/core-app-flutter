import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../core/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 16),
            const Text('CORE v0.1',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            const Text('Philosophical coaching for warriors',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.read<AppState>().clearAllData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data cleared')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Clear All Data'),
            ),
          ],
        ),
      ),
    );
  }
}