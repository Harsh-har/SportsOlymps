import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader("Account"),
          _buildSettingsTile(Icons.person_outline, "Account Information", "Phone number, Display name"),
          _buildSettingsTile(Icons.lock_outline, "Privacy & Security", "Password, Data privacy"),
          const SizedBox(height: 24),
          _buildSectionHeader("Preferences"),
          _buildSettingsTile(Icons.notifications_none, "Push Notifications", "Match alerts, Tournament updates"),
          _buildSettingsTile(Icons.language, "App Language", "English (Default)"),
          const SizedBox(height: 24),
          _buildSectionHeader("Support"),
          _buildSettingsTile(Icons.help_outline, "Help Center", "FAQs, Contact Support"),
          _buildSettingsTile(Icons.info_outline, "About BSO", "Version 1.0.0, Terms of Service"),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 12, left: 4),
    child: Text(title, style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1)),
  );

  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: const Color(0xFF1E2533), borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        onTap: () {},
      ),
    );
  }
}
