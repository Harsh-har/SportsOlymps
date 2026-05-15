import 'package:flutter/material.dart';
import '../challenge/incoming_challenge_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final isChallenge = index % 2 == 0;
          return GestureDetector(
            onTap: () {
              if (isChallenge) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IncomingChallengeScreen(
                      challengerName: "Rahul Verma",
                      sport: "Football",
                      date: "Oct 28, 2024",
                      time: "05:30 PM",
                      venue: "Central Park Stadium", challengeId: '',
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2533),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: isChallenge 
                        ? const Color(0xFFFF6B35).withOpacity(0.1) 
                        : const Color(0xFF00E676).withOpacity(0.1),
                    child: Icon(
                      isChallenge ? Icons.sports_handball : Icons.emoji_events,
                      color: isChallenge ? const Color(0xFFFF6B35) : const Color(0xFF00E676),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isChallenge ? "Match Challenge" : "Tournament Update",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isChallenge 
                              ? "Rahul Verma has challenged you to a match. Click to respond."
                              : "Dehradun City Open starts soon. Check your schedule!",
                          style: const TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        const Text("10 minutes ago", style: TextStyle(color: Colors.white24, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
