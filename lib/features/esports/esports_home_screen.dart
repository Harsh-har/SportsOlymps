import 'package:flutter/material.dart';

class EsportsHomeScreen extends StatelessWidget {
  const EsportsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("eSports Arena", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              "Competitive Gaming",
              style: TextStyle(color: Color(0xFFFF6B35), fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Join tournaments and earn merit in the digital arena.",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 30),
            _buildGameCard("BGMI", "1.2M Players", "assets/images/logo.png", true),
            const SizedBox(height: 16),
            _buildGameCard("Free Fire", "800K Players", "assets/images/logo.png", true),
            const SizedBox(height: 16),
            _buildGameCard("Valorant Mobile", "Coming Soon", "assets/images/logo.png", false),
            const SizedBox(height: 30),
            const Text(
              "Live Tournaments",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildLiveTournament("Battle of Gods", "BGMI", "₹10,000 Pool"),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(String title, String players, String image, bool active) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: active ? const Color(0xFFFF6B35).withOpacity(0.3) : Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            height: 60, width: 60,
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.videogame_asset, color: Colors.white70),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(players, style: TextStyle(color: active ? const Color(0xFF00E676) : Colors.white24, fontSize: 13)),
              ],
            ),
          ),
          if (active) const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
        ],
      ),
    );
  }

  Widget _buildLiveTournament(String title, String game, String prize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF448AFF).withOpacity(0.2), const Color(0xFF1E2533)]),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF448AFF).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.live_tv, color: Colors.redAccent, size: 16),
              const SizedBox(width: 8),
              Text("LIVE NOW • $game", style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("Grand Prize: $prize", style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          SliverButton(label: "Watch Stream", onTap: () {}),
        ],
      ),
    );
  }
}

class SliverButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const SliverButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF448AFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
