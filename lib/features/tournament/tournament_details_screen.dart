import 'package:flutter/material.dart';

class TournamentDetailsScreen extends StatelessWidget {
  final String title;
  final String sport;
  final String prize;

  const TournamentDetailsScreen({
    super.key,
    required this.title,
    required this.sport,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF1A1F2E),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFFFF6B35).withOpacity(0.1),
                child: const Icon(Icons.emoji_events, size: 80, color: Color(0xFFFF6B35)),
              ),
            ),
            leading: const BackButton(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sport, style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.bold)),
                      Text(prize, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Dehradun, Uttarakhand", style: TextStyle(color: Colors.white54, fontSize: 16)),
                  const SizedBox(height: 30),
                  const Text("Description", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "Participate in the biggest sports event in the city. Compete with top athletes and win exciting prizes and scholarships. This tournament is recognized by Bharat Sports Olymps for merit ranking.",
                    style: TextStyle(color: Colors.white70, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  _buildDetailRow(Icons.calendar_today, "Registration Ends", "Oct 24, 2024"),
                  _buildDetailRow(Icons.people, "Participants", "128 / 256 joined"),
                  _buildDetailRow(Icons.rule, "Format", "Knockout Rounds"),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFF1A1F2E),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text("Register for ₹15", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white38, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
