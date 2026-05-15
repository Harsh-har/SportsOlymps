import 'package:flutter/material.dart';

class HallOfFameScreen extends StatelessWidget {
  const HallOfFameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Hall of Fame", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Season 1 Legends",
              style: TextStyle(color: Color(0xFFFF6B35), fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Recognizing the elite athletes of Dehradun.",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 30),
            _buildLegendCard("Arjun Singh", "Football", "MVP of October", "assets/images/logo.png"),
            _buildLegendCard("Priya Sharma", "Badminton", "Undefeated Streak (15-0)", "assets/images/logo.png"),
            _buildLegendCard("Rohit Kumar", "Chess", "State Grandmaster Title", "assets/images/logo.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendCard(String name, String sport, String achievement, String image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF1E2533), const Color(0xFF1A1F2E)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFF6B35).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            height: 60, width: 60,
            decoration: BoxDecoration(color: const Color(0xFFFF6B35).withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.stars, color: Color(0xFFFF6B35), size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(sport, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.w500, fontSize: 12)),
                const SizedBox(height: 4),
                Text(achievement, style: const TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
