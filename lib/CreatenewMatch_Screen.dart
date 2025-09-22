import 'package:flutter/material.dart';

class CreateMatchScreen extends StatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  String selectedSport = "Cricket";
  bool isRanked = true;
  String opponentType = "Random Opponent";
  DateTime selectedDate = DateTime(2024, 10, 26);
  TimeOfDay selectedTime = const TimeOfDay(hour: 10, minute: 0);
  TextEditingController venueController =
  TextEditingController(text: "Central Park Stadium");
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create New Match",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Avatar.png"),
            radius: 18,
          ),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              child: DropdownButtonFormField<String>(
                value: selectedSport,
                decoration: const InputDecoration(
                  labelText: "Select Sport",
                  border: InputBorder.none,
                ),
                items: ["Cricket", "Football", "Tennis"]
                    .map((sport) =>
                    DropdownMenuItem(value: sport, child: Text(sport)))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedSport = value!);
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Match Type",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: !isRanked
                                ? Colors.blue.shade50
                                : Colors.white,
                          ),
                          onPressed: () {
                            setState(() => isRanked = false);
                          },
                          child: const Text("Friendly"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                            isRanked ? Color(0xFF0072D6) : Colors.white,
                          ),
                          onPressed: () {
                            setState(() => isRanked = true);
                          },
                          child: Text(
                            "Ranked",
                            style: TextStyle(
                                color: isRanked ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (isRanked)
                    Text.rich(
                      TextSpan(
                        text: "Estimated fee for Ranked\nmatches : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,

                        ),

                        children: [
                          TextSpan(
                            text: "   30 Credits (₹450)",
                            style: const TextStyle(
                              color: Color(0xFF0072D6),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Opponent Type",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildRadioOption("Friend"),
                  _buildRadioOption("Specific Opponent"),
                  _buildRadioOption("Random Opponent"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Schedule Match",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                        "${selectedDate.toLocal().toString().split(' ')[0]}"),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.access_time),
                    title: Text("${selectedTime.format(context)}"),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (picked != null) {
                        setState(() => selectedTime = picked);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Match Venue",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: venueController,
                          decoration:
                          const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {},
                        icon: const Icon(Icons.my_location, color: Colors.white),
                        label: const Text("Detect",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: TextField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText:
                  "Additional Notes (Any specific instructions or details for the match...)",
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Estimated Credits: 30 Credits",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700)),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {},
                  child: const Icon(Icons.add, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }

  Widget _buildRadioOption(String title) {
    return RadioListTile<String>(
      dense: true,
      value: title,
      groupValue: opponentType,
      onChanged: (value) {
        setState(() => opponentType = value!);
      },
      title: Text(title),
    );
  }
}
