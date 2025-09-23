import 'package:flutter/material.dart';

class DiscoverPlayersScreen extends StatefulWidget {
  const DiscoverPlayersScreen({super.key});

  @override
  State<DiscoverPlayersScreen> createState() => _DiscoverPlayersScreenState();
}

class _DiscoverPlayersScreenState extends State<DiscoverPlayersScreen> {
  bool isListView = true;

  final List<Map<String, dynamic>> players = [
    {
      "name": "Alex Johnson",
      "location": "Los Angeles, CA",
      "rating": 4.8,
      "image": "https://randomuser.me/api/portraits/men/10.jpg"
    },
    {
      "name": "Maria Garcia",
      "location": "San Francisco, CA",
      "rating": 4.5,
      "image": "https://randomuser.me/api/portraits/women/11.jpg"
    },
    {
      "name": "David Lee",
      "location": "Seattle, WA",
      "rating": 4.2,
      "image": "https://randomuser.me/api/portraits/men/12.jpg"
    },
    {
      "name": "Sophia Chen",
      "location": "New York, NY",
      "rating": 4.9,
      "image": "https://randomuser.me/api/portraits/women/13.jpg"
    },
    {
      "name": "Omar Hassan",
      "location": "Houston, TX",
      "rating": 4.1,
      "image": "https://randomuser.me/api/portraits/men/14.jpg"
    },
    {
      "name": "Isabelle Dubois",
      "location": "Miami, FL",
      "rating": 4.7,
      "image": "https://randomuser.me/api/portraits/women/15.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Discover Players",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ✅ Toggle Buttons
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isListView = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isListView ? Color(0xFF008AE0) : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "List View",
                          style: TextStyle(
                            color: isListView ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isListView = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !isListView ? Color(0xFF008AE0) : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Map View",
                          style: TextStyle(
                            color: !isListView ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ List of Players
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final player = players[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(player["image"]),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              player["location"],
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star_border,
                                    color: Color(0xFF008AE0), size: 18),
                                Text(
                                  player["rating"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Challenge"),
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
