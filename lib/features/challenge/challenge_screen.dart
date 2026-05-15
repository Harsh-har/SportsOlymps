import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../tournament/tournament_list_screen.dart';
import 'player_discovery_screen.dart';
import 'cricket_role_selection_screen.dart';
import 'incoming_challenge_screen.dart';

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
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
      builder: (context, snapshot) {
        String city = "Loading...";
        if (snapshot.hasData && snapshot.data!.exists) {
          city = (snapshot.data!.data() as Map<String, dynamic>)['city'] ?? "Unknown City";
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Challenges",
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    _buildLocationBadge(city),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Find athletes in your city and climb the ranks",
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 24),

                // New: Pending Requests Section
                _buildPendingRequestsCard(context),
                const SizedBox(height: 24),

                _challengeTypeCard(
                  icon: Icons.emoji_events,
                  title: "Ranked Match",
                  subtitle: "Earn ELO points • ₹15 entry fee",
                  color: const Color(0xFFFF6B35),
                  badge: "₹15",
                  onTap: () => _handleFindPlayers(),
                ),
                const SizedBox(height: 12),
                _challengeTypeCard(
                  icon: Icons.handshake_outlined,
                  title: "Friendly Match",
                  subtitle: "Practice session • Free entry",
                  color: const Color(0xFF00E676),
                  badge: "FREE",
                  onTap: () => _handleFindPlayers(),
                ),
                const SizedBox(height: 12),
                _challengeTypeCard(
                  icon: Icons.military_tech_outlined,
                  title: "Join Tournament",
                  subtitle: "City Quarterly • 3 months cycle",
                  color: const Color(0xFF448AFF),
                  badge: "OPEN",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TournamentListScreen()));
                  },
                ),
                const SizedBox(height: 28),
                const Text(
                  "Select a Sport",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                _buildSportsGrid(),
                const SizedBox(height: 28),
                _buildFindButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildPendingRequestsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // For prototype: Open a sample incoming challenge
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IncomingChallengeScreen(
              challengeId: "sample_id_123",
              challengerName: "Rahul Verma",
              sport: "Football",
              date: "Oct 28, 2024",
              time: "05:00 PM",
              venue: "Central Park Stadium",
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2533),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF00E676).withOpacity(0.5)),
        ),
        child: Row(
          children: [
            const Icon(Icons.mail_outline, color: Color(0xFF00E676), size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "You have 1 pending match request",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            const Text(
              "View",
              style: TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF00E676), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationBadge(String location) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B35).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFF6B35).withOpacity(0.3)),
      ),
      child: Text("📍 $location", style: const TextStyle(color: Color(0xFFFF6B35), fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSportsGrid() {
    return GridView.count(
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
              color: isSelected ? const Color(0xFFFF6B35).withOpacity(0.15) : const Color(0xFF1E2533),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? const Color(0xFFFF6B35) : Colors.white12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(sport["icon"]!, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 4),
                Text(
                  sport["name"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: isSelected ? const Color(0xFFFF6B35) : Colors.white54, fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFindButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        icon: const Icon(Icons.search, color: Colors.white),
        label: Text("Find $_selectedSport Players", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        onPressed: () => _handleFindPlayers(),
      ),
    );
  }

  void _handleFindPlayers() {
    if (_selectedSport == "Cricket") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PlayerDiscoveryScreen(sport: _selectedSport)));
    }
  }

  Widget _challengeTypeCard({required IconData icon, required String title, required String subtitle, required Color color, required String badge, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E2533), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.3))),
        child: Row(
          children: [
            Container(
              height: 50, width: 50,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
              child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
