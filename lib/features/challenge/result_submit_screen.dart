import 'package:flutter/material.dart';

class ResultSubmitScreen extends StatefulWidget {
  final String opponentName;
  final String sport;

  const ResultSubmitScreen({super.key, required this.opponentName, required this.sport});

  @override
  State<ResultSubmitScreen> createState() => _ResultSubmitScreenState();
}

class _ResultSubmitScreenState extends State<ResultSubmitScreen> {
  final _myScoreController = TextEditingController();
  final _opponentScoreController = TextEditingController();
  String _matchStatus = "Win"; // Default status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Submit Result", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Final Score",
              style: TextStyle(color: Color(0xFFFF6B35), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Enter the final results for your ${widget.sport} match against ${widget.opponentName}.",
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildScoreField("Your Score", _myScoreController)),
                const SizedBox(width: 20),
                const Text("-", style: TextStyle(color: Colors.white38, fontSize: 32)),
                const SizedBox(width: 20),
                Expanded(child: _buildScoreField("${widget.opponentName}'s Score", _opponentScoreController)),
              ],
            ),
            const SizedBox(height: 32),
            const Text("Match Outcome", style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildOutcomeSelector(),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Result submitted for verification"), backgroundColor: Colors.green));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("Submit for Approval", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1E2533),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildOutcomeSelector() {
    return Row(
      children: ["Win", "Loss", "Draw"].map((status) {
        final isSelected = _matchStatus == status;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _matchStatus = status),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF6B35).withOpacity(0.1) : const Color(0xFF1E2533),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? const Color(0xFFFF6B35) : Colors.transparent),
              ),
              child: Center(
                child: Text(status, style: TextStyle(color: isSelected ? const Color(0xFFFF6B35) : Colors.white54, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
