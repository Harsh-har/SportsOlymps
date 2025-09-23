import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> players = const [
    {
      "rank": 1,
      "name": "Ethan Blackwood",
      "rating": 2500,
      "wins": 150,
      "losses": 10,
      "image": "https://randomuser.me/api/portraits/men/20.jpg",
      "tags": ["Grandmaster", "Legendary Streak", "Season MVP"]
    },
    {
      "rank": 2,
      "name": "Sophia Chen",
      "rating": 2450,
      "wins": 145,
      "losses": 12,
      "image": "https://randomuser.me/api/portraits/women/21.jpg",
      "tags": ["Tactician", "Top 10", "Veteran"]
    },
    {
      "rank": 3,
      "name": "Liam O'Connell",
      "rating": 2400,
      "wins": 140,
      "losses": 15,
      "image": "https://randomuser.me/api/portraits/men/22.jpg",
      "tags": ["Strategist", "Elite Player"]
    },
    {
      "rank": 4,
      "name": "Ava Rodriguez",
      "rating": 2350,
      "wins": 130,
      "losses": 20,
      "image": "https://randomuser.me/api/portraits/women/23.jpg",
      "tags": ["Rising Star", "Consistent Performer"]
    },
    {
      "rank": 5,
      "name": "Noah Patel",
      "rating": 2300,
      "wins": 125,
      "losses": 22,
      "image": "https://randomuser.me/api/portraits/men/24.jpg",
      "tags": ["Newcomer Elite", "Fast Learner"]
    },
    {
      "rank": 6,
      "name": "Olivia White",
      "rating": 2280,
      "wins": 120,
      "losses": 25,
      "image": "https://randomuser.me/api/portraits/women/25.jpg",
      "tags": ["Team Player", "Iron Will"]
    },
    {
      "rank": 7,
      "name": "Lucas Green",
      "rating": 2260,
      "wins": 118,
      "losses": 23,
      "image": "https://randomuser.me/api/portraits/men/26.jpg",
      "tags": ["Grinder", "Veteran"]
    },
    {
      "rank": 8,
      "name": "Mia Hall",
      "rating": 2240,
      "wins": 115,
      "losses": 24,
      "image": "https://randomuser.me/api/portraits/women/27.jpg",
      "tags": ["Sharp Shooter"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/28.jpg"),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Dropdown Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: "Esports",
                  items: ["Esports", "Football", "Basketball"].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: "National",
                  items: ["National", "International"].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: "Pro",
                  items: ["Pro", "Amateur"].map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          // Leaderboard List
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Rank
                      Text(
                        "${player["rank"]}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(width: 12),

                      // Profile Image
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(player["image"]),
                      ),
                      const SizedBox(width: 12),

                      // Player Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text("Rating: ${player["rating"]}",
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text("Wins: ${player["wins"]}",
                                    style: const TextStyle(
                                        color: Colors.green, fontWeight: FontWeight.w600)),
                                const SizedBox(width: 20),
                                Text("Losses: ${player["losses"]}",
                                    style: TextStyle(
                                        color: Colors.red.shade400, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Tags
                            Wrap(
                              spacing: 6,
                              children: (player["tags"] as List<String>).map((tag) {
                                final isGreen = tag == "Grandmaster" ||
                                    tag == "Season MVP" ||
                                    tag == "Tactician" ||
                                    tag == "Strategist" ||
                                    tag == "Rising Star" ||
                                    tag == "Newcomer Elite" ||
                                    tag == "Team Player" ||
                                    tag == "Grinder" ||
                                    tag == "Sharp Shooter";
                                return Chip(
                                  label: Text(tag,
                                      style: TextStyle(
                                          color: isGreen ? Colors.black : Colors.black)),
                                  backgroundColor:
                                  isGreen ? Colors.greenAccent.shade400 : Colors.grey.shade200,
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
