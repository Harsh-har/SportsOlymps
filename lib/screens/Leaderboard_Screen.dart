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
    "Chess", "Kabaddi", "Cricket", "BGMI"
  ];

  final List<String> _levels = ["City", "District", "State", "Bharat"];

  final List<Map<String, String>> _players = const [
    {"rank": "1", "name": "Arjun Singh", "elo": "1580", "sport": "Football"},
    {"rank": "2", "name": "Priya Rawat", "elo": "1520", "sport": "Badminton"},
    {"rank": "3", "name": "Rohit Negi", "elo": "1490", "sport": "Chess"},
    {"rank": "4", "name": "Sunita Bisht", "elo": "1340", "sport": "Kabaddi"},
    {"rank": "5", "name": "Vikram Rana", "elo": "1290", "sport": "Football"},
    {"rank": "6", "name": "Ankit Joshi", "elo": "1240", "sport": "Cricket"},
    {"rank": "7", "name": "You", "elo": "1200", "sport": "Football"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Leaderboard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFFF6B35).withOpacity(0.3),
                        ),
                      ),
                      child: const Text(
                        "📍 Dehradun",
                        style: TextStyle(
                          color: Color(0xFFFF6B35),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Level Filter
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _levels.map((level) {
                      final isSelected = _selectedLevel == level;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedLevel = level),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFF6B35)
                                : const Color(0xFF1E2533),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            level,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white54,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 12),

                // Sport Filter
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _sports.map((sport) {
                      final isSelected = _selectedSport == sport;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSport = sport),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF00E676).withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF00E676)
                                  : Colors.white12,
                            ),
                          ),
                          child: Text(
                            sport,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFF00E676)
                                  : Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Players List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _players.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final p = _players[index];
                final isMe = p["name"] == "You";
                final rank = int.parse(p["rank"]!);

                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isMe
                        ? const Color(0xFFFF6B35).withOpacity(0.1)
                        : const Color(0xFF1E2533),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isMe
                          ? const Color(0xFFFF6B35).withOpacity(0.4)
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        child: Text(
                          rank <= 3
                              ? ["🥇", "🥈", "🥉"][rank - 1]
                              : "#${p["rank"]}",
                          style: TextStyle(
                            color: rank <= 3 ? Colors.white : Colors.white54,
                            fontSize: rank <= 3 ? 22 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color(0xFFFF6B35).withOpacity(0.2)
                              : Colors.white10,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            p["name"]![0],
                            style: TextStyle(
                              color: isMe
                                  ? const Color(0xFFFF6B35)
                                  : Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isMe ? "You (Me)" : p["name"]!,
                              style: TextStyle(
                                color: isMe
                                    ? const Color(0xFFFF6B35)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              p["sport"]!,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        p["elo"]!,
                        style: const TextStyle(
                          color: Color(0xFF00E676),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}