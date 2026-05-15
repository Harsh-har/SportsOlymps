import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../notification/notification_screen.dart';
import '../profile/wallet_screen.dart';
import '../tournament/tournament_list_screen.dart';
import '../challenge/sports_selection_screen.dart';
import '../leaderboard/leaderboard_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
      builder: (context, snapshot) {
        String name = user?.displayName ?? "Athlete";
        String city = "Loading...";
        String state = "";

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          name = data['name'] ?? name;
          city = data['city'] ?? "Unknown City";
          state = data['state'] ?? "";
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome back, Champion! 🏆",
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E676).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF00E676).withOpacity(0.3)),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF00E676), size: 16),
                                SizedBox(width: 6),
                                Text("₹450", style: TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NotificationScreen()),
                          ),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35).withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: Color(0xFFFF6B35),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildEloCard(city, state),
                const SizedBox(height: 24),
                _sectionTitle("Quick Actions"),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _actionCard(
                        icon: Icons.sports_handball,
                        label: "Challenge",
                        color: const Color(0xFF00E676),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SportsSelectionScreen())),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _actionCard(
                        icon: Icons.emoji_events_outlined,
                        label: "Tournament",
                        color: const Color(0xFFFF6B35),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TournamentListScreen())),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _actionCard(
                        icon: Icons.leaderboard_outlined,
                        label: "Rankings",
                        color: const Color(0xFF448AFF),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Scaffold(backgroundColor: Color(0xFF0D1117), body: LeaderboardScreen()))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _sectionTitle("Nearby Players"),
                const SizedBox(height: 14),
                _nearbyPlayerCard(name: "Arjun Singh", sport: "Football", elo: "1340", location: city),
                const SizedBox(height: 10),
                _nearbyPlayerCard(name: "Priya Sharma", sport: "Badminton", elo: "1180", location: city),
                const SizedBox(height: 24),
                _sectionTitle("Recent Match Results"),
                const SizedBox(height: 14),
                _matchCard(result: "WON", opponent: "Rahul Verma", sport: "Football", points: "+24"),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEloCard(String city, String state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFE85D26)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                "City Rank • $city${state.isNotEmpty ? ', $state' : ''}",
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Current ELO Rating", style: TextStyle(color: Colors.white70, fontSize: 13)),
          const Text("1,200", style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          Row(
            children: [
              _statChip("24", "Matches"),
              const SizedBox(width: 12),
              _statChip("18", "Wins"),
              const SizedBox(width: 12),
              _statChip("75%", "Win Rate"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget _statChip(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _actionCard({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _nearbyPlayerCard({required String name, required String sport, required String elo, required String location}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF1E2533), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFF6B35).withOpacity(0.15),
            child: Text(name[0], style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                Text("$sport • $location", style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Text("ELO $elo", style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _matchCard({required String result, required String opponent, required String sport, required String points}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFF1E2533), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Text(result, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("vs $opponent", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                Text(sport, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Text(points, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
