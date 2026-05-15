import 'package:flutter/material.dart';
import '../challenge/send_challenge_screen.dart';

class AthleteDetailScreen extends StatelessWidget {
  final String name;
  final String sport;
  final String city;
  final String elo;

  const AthleteDetailScreen({
    super.key,
    required this.name,
    required this.sport,
    required this.city,
    required this.elo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFFF6B35).withOpacity(0.1),
                child: Text(name[0], style: const TextStyle(fontSize: 48, color: Color(0xFFFF6B35), fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
            Text("$sport Athlete • $city", style: const TextStyle(color: Colors.white54, fontSize: 16)),
            const SizedBox(height: 30),
            _buildStatsSection(),
            const SizedBox(height: 40),
            _buildAchievementList(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Color(0xFF1A1F2E), borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("Message", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendChallengeScreen(opponentName: name, sport: sport, opponentId: '',),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("Send Challenge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("ELO", elo),
          _statItem("Rank", "#12"),
          _statItem("Wins", "45"),
        ],
      ),
    );
  }

  Widget _statItem(String label, String val) => Column(
    children: [
      Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
      const SizedBox(height: 4),
      Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    ],
  );

  Widget _buildAchievementList() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Achievements", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _AchievementRow(text: "Winner of City Quarterly Oct 2024"),
          _AchievementRow(text: "Highest Win Streak: 8 Matches"),
        ],
      ),
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final String text;
  const _AchievementRow({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [const Icon(Icons.stars, color: Color(0xFF00E676), size: 16), const SizedBox(width: 10), Text(text, style: const TextStyle(color: Colors.white70))]),
    );
  }
}
