import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedSport = "All Sports";
  String _selectedLevel = "City";

  final List<String> _sports = [
    "All Sports", "Football", "Badminton",
    "Chess", "Kabaddi", "Cricket", "Basketball"
  ];

  final List<String> _levels = ["City", "District", "State", "National"];

  final List<Map<String, String>> _players = const [
    {"rank": "1", "name": "Arjun Singh", "elo": "1580", "sport": "Football"},
    {"rank": "2", "name": "Priya Sharma", "elo": "1520", "sport": "Badminton"},
    {"rank": "3", "name": "Rohit Kumar", "elo": "1490", "sport": "Chess"},
    {"rank": "4", "name": "Sunita Devi", "elo": "1340", "sport": "Kabaddi"},
    {"rank": "5", "name": "Vikram Singh", "elo": "1290", "sport": "Football"},
    {"rank": "6", "name": "Ankit Verma", "elo": "1240", "sport": "Cricket"},
    {"rank": "7", "name": "You", "elo": "1200", "sport": "Football"},
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rankings",
                          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        _buildLocationBadge(city),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildFilterRow(_levels, _selectedLevel, (val) => setState(() => _selectedLevel = val)),
                    const SizedBox(height: 12),
                    _buildFilterRow(_sports, _selectedSport, (val) => setState(() => _selectedSport = val), isSmall: true),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _players.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final p = _players[index];
                    return _buildPlayerCard(p, p["name"] == "You");
                  },
                ),
              ),
            ],
          ),
        );
      }
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

  Widget _buildFilterRow(List<String> items, String selected, Function(String) onSelect, {bool isSmall = false}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          final isSelected = selected == item;
          return GestureDetector(
            onTap: () => onSelect(item),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: isSmall ? 14 : 18, vertical: isSmall ? 6 : 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFF1E2533),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(item, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontSize: isSmall ? 12 : 14, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlayerCard(Map<String, String> player, bool isMe) {
    final rank = int.parse(player["rank"]!);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFFF6B35).withOpacity(0.1) : const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isMe ? const Color(0xFFFF6B35).withOpacity(0.5) : Colors.transparent),
      ),
      child: Row(
        children: [
          SizedBox(width: 35, child: Text(rank <= 3 ? ["🥇", "🥈", "🥉"][rank - 1] : "#$rank", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(width: 10),
          CircleAvatar(backgroundColor: Colors.white12, child: Text(player["name"]![0], style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isMe ? "You" : player["name"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(player["sport"]!, style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Text(player["elo"]!, style: const TextStyle(color: Color(0xFF00E676), fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}
