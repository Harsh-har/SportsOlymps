import 'package:flutter/material.dart';

class TournamentListScreen extends StatelessWidget {
  const TournamentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Tournaments", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTournamentCard(
            title: "Dehradun City Open",
            date: "Oct 25 - Oct 30, 2024",
            sport: "Football",
            prize: "₹5,000 Prize",
            status: "Registration Open",
          ),
          const SizedBox(height: 16),
          _buildTournamentCard(
            title: "Bharat Merit Cup",
            date: "Nov 12 - Nov 18, 2024",
            sport: "Cricket",
            prize: "Scholarship Trophy",
            status: "Coming Soon",
          ),
          const SizedBox(height: 16),
          _buildTournamentCard(
            title: "State Badminton League",
            date: "Dec 01 - Dec 05, 2024",
            sport: "Badminton",
            prize: "₹10,000 + Medal",
            status: "Registration Open",
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentCard({
    required String title,
    required String date,
    required String sport,
    required String prize,
    required String status,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(
              child: Icon(Icons.emoji_events, size: 64, color: Color(0xFFFF6B35)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sport, style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: status.contains("Open") ? const Color(0xFF00E676).withOpacity(0.1) : Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: status.contains("Open") ? const Color(0xFF00E676) : Colors.white54,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.stars, color: Color(0xFF00E676), size: 16),
                    const SizedBox(width: 6),
                    Text(prize, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: status.contains("Open") ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B35),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
