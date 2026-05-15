import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendChallengeScreen extends StatefulWidget {
  final String opponentId; // Added to identify receiver in DB
  final String opponentName;
  final String sport;

  const SendChallengeScreen({
    super.key,
    required this.opponentId,
    required this.opponentName,
    required this.sport,
  });

  @override
  State<SendChallengeScreen> createState() => _SendChallengeScreenState();
}

class _SendChallengeScreenState extends State<SendChallengeScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 17, minute: 0);
  final _venueController = TextEditingController();
  String _matchType = "Ranked";
  bool _isSending = false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _sendChallengeToFirebase() async {
    final venue = _venueController.text.trim();
    if (venue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please specify a venue"), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _isSending = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Create DateTime object for the match
      final matchDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // Save to Firestore
      final challengeDoc = FirebaseFirestore.instance.collection('challenges').doc();
      await challengeDoc.set({
        'challengeId': challengeDoc.id,
        'challengerId': user.uid,
        'challengerName': user.displayName ?? "Athlete",
        'receiverId': widget.opponentId,
        'receiverName': widget.opponentName,
        'sport': widget.sport,
        'matchType': _matchType,
        'venue': venue,
        'matchTime': Timestamp.fromDate(matchDateTime),
        'status': 'pending', // pending, accepted, rejected, completed
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Also create a notification for the receiver
      await FirebaseFirestore.instance.collection('notifications').add({
        'userId': widget.opponentId,
        'title': 'New Challenge!',
        'message': '${user.displayName ?? "An athlete"} challenged you to a ${widget.sport} match.',
        'type': 'challenge',
        'challengeId': challengeDoc.id,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Challenge sent successfully! ✅"), backgroundColor: Color(0xFF00E676)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Send Challenge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Opponent Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2533),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFF6B35).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFFF6B35).withOpacity(0.1),
                    child: Text(widget.opponentName[0], style: const TextStyle(color: Color(0xFFFF6B35))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Challenging", style: TextStyle(color: Colors.white38, fontSize: 12)),
                        Text(widget.opponentName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
                    child: Text(widget.sport, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildSectionLabel("Select Date & Time"),
            Row(
              children: [
                Expanded(
                  child: _buildPickerTile(
                    icon: Icons.calendar_today,
                    label: "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                    onTap: _pickDate,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPickerTile(
                    icon: Icons.access_time,
                    label: _selectedTime.format(context),
                    onTap: _pickTime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionLabel("Match Venue / Area"),
            TextField(
              controller: _venueController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter stadium or park name...",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: const Color(0xFF1E2533),
                prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionLabel("Match Type"),
            Row(
              children: ["Ranked", "Friendly"].map((type) {
                final isSelected = _matchType == type;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _matchType = type),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFF6B35).withOpacity(0.1) : const Color(0xFF1E2533),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? const Color(0xFFFF6B35) : Colors.transparent),
                      ),
                      child: Center(
                        child: Text(type, style: TextStyle(color: isSelected ? const Color(0xFFFF6B35) : Colors.white54, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendChallengeToFirebase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isSending 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Send Challenge", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPickerTile({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E2533), borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFFF6B35), size: 20),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
