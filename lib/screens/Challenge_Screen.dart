import 'package:flutter/material.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  String _selectedSport = "Football";

  final List<Map<String, String>> _sports = [
    {"name": "Football", "icon": "⚽"},
    {"name": "Badminton", "icon": "🏸"},
    {"name": "Chess", "icon": "♟️"},
    {"name": "Cricket", "icon": "🏏"},
    {"name": "Kabaddi", "icon": "🤼"},
    {"name": "Table Tennis", "icon": "🏓"},
    {"name": "Kho-Kho", "icon": "🏃"},
    {"name": "BGMI", "icon": "🎮"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Challenge",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Apne city ke players ko challenge karo",
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),

            const SizedBox(height: 24),

            // Match Types
            _challengeTypeCard(
              icon: Icons.emoji_events,
              title: "Ranked Match",
              subtitle: "ELO points milenge • ₹15 entry",
              color: const Color(0xFFFF6B35),
              badge: "₹15",
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _challengeTypeCard(
              icon: Icons.handshake_outlined,
              title: "Friendly Match",
              subtitle: "Practice karo • Free entry",
              color: const Color(0xFF00E676),
              badge: "FREE",
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _challengeTypeCard(
              icon: Icons.military_tech_outlined,
              title: "Join Tournament",
              subtitle: "City Quarterly • 3 months cycle",
              color: const Color(0xFF448AFF),
              badge: "OPEN",
              onTap: () {},
            ),

            const SizedBox(height: 28),

            // Sport Select
            const Text(
              "Sport Select Karo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: _sports.map((sport) {
                final isSelected = _selectedSport == sport["name"];
                return GestureDetector(
                  onTap: () => setState(() => _selectedSport = sport["name"]!),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFF6B35).withOpacity(0.15)
                          : const Color(0xFF1E2533),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFFF6B35)
                            : Colors.white12,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sport["icon"]!,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sport["name"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFFF6B35)
                                : Colors.white54,
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            // Find Players Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.search, color: Colors.white),
                label: Text(
                  "Find $_selectedSport Players  →",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _challengeTypeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2533),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}