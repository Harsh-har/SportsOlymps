import 'package:flutter/material.dart';
import 'CreateMatch_Screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Matches"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Leaderboard"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ AppBar Row
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Sports Olymps",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.notifications_none, size: 28),
                ],
              ),

              const SizedBox(height: 16),

              // ✅ Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF3F4F6),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search sports, teams, or players...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Quick Actions
              const Text(
                "Quick Actions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.8,
                children: [
                  _quickActionCard(
                    context,
                    Icons.sports_tennis,
                    "Create Match",
                    const Color(0xFFF2F4FD),
                    const SportsSelectionScreen(),
                    const Color(0xFF5774EA),
                  ),
                  _quickActionCard(
                    context,
                    Icons.group,
                    "Find Opponent",
                    const Color(0xFFFCE1DE),
                    const SportsSelectionScreen(),
                    const Color(0xFFF1705F),
                  ),
                  _quickActionCard(
                    context,
                    Icons.emoji_events,
                    "My Challenges",
                    const Color(0xFFF2F4FD),
                    const SportsSelectionScreen(),
                    const Color(0xFF5774EA),
                  ),
                  _quickActionCard(
                    context,
                    Icons.calendar_today,
                    "My Next Match",
                    const Color(0xFFFCE1DE),
                    const SportsSelectionScreen(),
                    const Color(0xFFF1705F),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ✅ Latest Updates
              const Text(
                "Latest Updates",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              _updateCard(
                "Jessica A.",
                "2 hours ago",
                "Jessica A. won her tennis match against Mark T. with a score of 6-4, 6-2!",
                "https://randomuser.me/api/portraits/women/44.jpg",
              ),
              const SizedBox(height: 12),

              _updateCard(
                "Coach Miller",
                "Yesterday",
                "New tip: Improve your serve with these 3 essential drills. Check out the full guide in Discover!",
                "https://randomuser.me/api/portraits/men/32.jpg",
              ),

              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All Results >",
                    style: TextStyle(color: Color(0xFF5774EA)),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // ✅ Leaderboard Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Chips Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Leaderboard",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          _chip("City", true),
                          const SizedBox(width: 8),
                          _chip("State", false),
                          const SizedBox(width: 8),
                          _chip("National", false),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Table Style Leaderboard
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Header Row
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Rank",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text("Player",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("Score",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),

                        const Divider(height: 1),

                        // Leaderboard Rows
                        const _leaderboardRow("1", "Alex Johnson", "1500 pts"),
                        const Divider(height: 1),
                        const _leaderboardRow("2", "Maria Santos", "1480 pts"),
                        const Divider(height: 1),
                        const _leaderboardRow("3", "David Lee", "1450 pts"),
                        const Divider(height: 1),
                        const _leaderboardRow("4", "Sarah Chen", "1420 pts"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // View All Rankings Link
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "View All Rankings",
                        style: TextStyle(
                          color: Color(0xFF5774EA),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ✅ Wallet
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFACFC9), Color(0xFFFFEBE8)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Wallet",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Current Balance",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "₹125.50",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "50 Bonus Credits",
                          style: TextStyle(color: Color(0xFFE06900)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF1705F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Add Money",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ Quick Action Card with Navigation + Icon Color
Widget _quickActionCard(
    BuildContext context,
    IconData icon,
    String text,
    Color bgColor,
    Widget nextScreen,
    Color iconColor,
    ) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(height: 6),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    ),
  );
}

// ✅ Updates Card
Widget _updateCard(String name, String time, String content, String imageUrl) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.share, size: 20, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 8),
        Text(content),
      ],
    ),
  );
}


Widget _chip(String text, bool selected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: selected ? Colors.blue.shade100 : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: selected ? Colors.blue : Colors.black87,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class _leaderboardRow extends StatelessWidget {
  final String rank;
  final String player;
  final String score;

  const _leaderboardRow(this.rank, this.player, this.score);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [

          Expanded(
            flex: 1,
            child: Text(
              rank,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),


          Expanded(
            flex: 3,
            child: Text(
              player,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black87),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              score,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
