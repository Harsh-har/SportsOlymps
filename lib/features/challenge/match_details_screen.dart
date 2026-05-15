import 'package:flutter/material.dart';
import 'chat_screen.dart';

class MatchDetailsScreen extends StatelessWidget {
  final String opponentName;
  final String sport;
  final String status;

  const MatchDetailsScreen({
    super.key,
    required this.opponentName,
    required this.sport,
    this.status = "Upcoming",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Match Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildMatchHeader(),
            const SizedBox(height: 32),
            _buildInfoSection(),
            const SizedBox(height: 32),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFF6B35).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildPlayerProfile("You"),
          const Text("VS", style: TextStyle(color: Color(0xFFFF6B35), fontSize: 24, fontWeight: FontWeight.w900)),
          _buildPlayerProfile(opponentName),
        ],
      ),
    );
  }

  Widget _buildPlayerProfile(String name) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.white10,
          child: Text(name[0], style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.sports_baseball, "Sport", sport),
          const Divider(color: Colors.white10, height: 32),
          _buildDetailRow(Icons.location_on, "Venue", "Central Park, Court 4"),
          const Divider(color: Colors.white10, height: 32),
          _buildDetailRow(Icons.calendar_today, "Date", "Tomorrow, Oct 28"),
          const Divider(color: Colors.white10, height: 32),
          _buildDetailRow(Icons.access_time, "Time", "05:00 PM"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFF6B35), size: 20),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 14)),
        const Spacer(),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(opponentName: opponentName),
                ),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            label: const Text("Chat with Opponent", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF448AFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: const Color(0xFF1E2533),
                title: const Text("Cancel Match", style: TextStyle(color: Colors.white)),
                content: const Text("Are you sure you want to cancel this match?", style: TextStyle(color: Colors.white70)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Go back
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Match Cancelled"), backgroundColor: Colors.redAccent),
                      );
                    },
                    child: const Text("Yes, Cancel", style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            );
          },
          child: const Text("Cancel Match", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
