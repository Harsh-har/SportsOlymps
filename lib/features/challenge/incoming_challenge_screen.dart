import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IncomingChallengeScreen extends StatefulWidget {
  final String challengeId; // Document ID from Firestore
  final String challengerName;
  final String sport;
  final String date;
  final String time;
  final String venue;

  const IncomingChallengeScreen({
    super.key,
    required this.challengeId,
    required this.challengerName,
    required this.sport,
    required this.date,
    required this.time,
    required this.venue,
  });

  @override
  State<IncomingChallengeScreen> createState() => _IncomingChallengeScreenState();
}

class _IncomingChallengeScreenState extends State<IncomingChallengeScreen> {
  bool _isProcessing = false;

  Future<void> _updateChallengeStatus(String status) async {
    setState(() => _isProcessing = true);
    try {
      // Update status in Firestore
      await FirebaseFirestore.instance
          .collection('challenges')
          .doc(widget.challengeId)
          .update({'status': status});

      if (mounted) {
        final color = status == 'accepted' ? const Color(0xFF00E676) : Colors.redAccent;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Challenge ${status.toUpperCase()}"),
            backgroundColor: color,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("New Challenge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFFF6B35).withOpacity(0.1),
              child: Text(
                widget.challengerName[0],
                style: const TextStyle(fontSize: 40, color: Color(0xFFFF6B35), fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.challengerName,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "has challenged you!",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
            const SizedBox(height: 40),
            _buildDetailCard(),
            const Spacer(),
            if (_isProcessing)
              const CircularProgressIndicator(color: Color(0xFFFF6B35))
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _updateChallengeStatus('rejected'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Reject", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _updateChallengeStatus('accepted'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00E676),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Accept", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2533),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.sports_soccer, "Sport", widget.sport),
          const Divider(color: Colors.white10, height: 24),
          _buildInfoRow(Icons.calendar_today, "Date", widget.date),
          const Divider(color: Colors.white10, height: 24),
          _buildInfoRow(Icons.access_time, "Time", widget.time),
          const Divider(color: Colors.white10, height: 24),
          _buildInfoRow(Icons.location_on_outlined, "Venue", widget.venue),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFF6B35), size: 20),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 14)),
        const Spacer(),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
