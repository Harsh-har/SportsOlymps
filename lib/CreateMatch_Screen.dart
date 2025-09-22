import 'package:flutter/material.dart';
import 'CircketRoleSelection_Screen.dart';


class SportsSelectionScreen extends StatefulWidget {
  const SportsSelectionScreen({super.key});

  @override
  State<SportsSelectionScreen> createState() => _SportsSelectionScreenState();
}

class _SportsSelectionScreenState extends State<SportsSelectionScreen> {
  final List<Map<String, String>> sports = [
    {
      "name": "Cricket",
      "image": "assets/images/cricketlogo.png",
    },
    {
      "name": "Badminton",
      "image": "assets/images/tabletanice.png",
    },
    {
      "name": "Table Tennis",
      "image": "assets/images/badmintan.png",
    },
    {
      "name": "Kabaddi",
      "image": "assets/images/kabaddi.png",
    },
    {
      "name": "Snooker",
      "image": "assets/images/snoker.png",
    },
  ];

  final List<String> selectedSports = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Choose Your Sports",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 1,
              childAspectRatio: 2.5,
              mainAxisSpacing: 12,
              children: sports.map((sport) {
                final isSelected = selectedSports.contains(sport["name"]);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedSports.remove(sport["name"]);
                      } else {
                        selectedSports.add(sport["name"]!);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                      image: DecorationImage(
                        image: AssetImage(sport["image"]!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Text(
                            sport["name"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Check if 'Cricket' is among the selected sports
                  if (selectedSports.contains("Cricket")) {
                    // Navigate to the RoleSelectionScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoleSelectionScreen(),
                      ),
                    );
                  } else {
                    // If Cricket is not selected, you can show a message
                    // or do nothing.
                    debugPrint("Please select Cricket to proceed.");
                  }
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}