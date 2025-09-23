import 'package:flutter/material.dart';



class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("My Wallet", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.jpg"), // replace with your asset
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("₹1,232",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F74C7))),
                SizedBox(width: 4),
                Text("INR", style: TextStyle(fontSize: 16, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_box),
                    label: const Text("Add Money"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0F74C7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.credit_card),
                    label: const Text("Purchase Credits"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0F74C7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text("Recent Transactions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Transactions List
            Column(
              children: const [
                TransactionTile(
                  title: "Credit Purchase (1000)",
                  date: "2024-07-25 10:30 AM",
                  amount: "+ ₹1,000",
                  status: "Completed",
                  statusColor: Colors.green,
                ),
                TransactionTile(
                  title: "Add Money via UPI",
                  date: "2024-07-24 03:15 PM",
                  amount: "+ ₹500",
                  status: "Completed",
                  statusColor: Colors.green,
                ),
                TransactionTile(
                  title: "Credit Purchase (500)",
                  date: "2024-07-23 09:00 AM",
                  amount: "+ ₹500",
                  status: "Pending",
                  statusColor: Colors.grey,
                ),
                TransactionTile(
                  title: "Add Money via Card",
                  date: "2024-07-22 11:45 AM",
                  amount: "+ ₹2,000",
                  status: "Completed",
                  statusColor: Colors.green,
                ),
                TransactionTile(
                  title: "Credit Purchase (200)",
                  date: "2024-07-21 02:00 PM",
                  amount: "+ ₹200",
                  status: "Failed",
                  statusColor: Colors.red,
                ),
                TransactionTile(
                  title: "Add Money via UPI",
                  date: "2024-07-20 08:00 AM",
                  amount: "+ ₹1,000",
                  status: "Completed",
                  statusColor: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String status;
  final Color statusColor;

  const TransactionTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500))),
                Text(amount,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date,
                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(status,
                      style: TextStyle(fontSize: 12, color: statusColor)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(Icons.receipt_long, size: 16, color: Color(0xFF0F74C7)),
                SizedBox(width: 4),
                Text("View Receipt",
                    style: TextStyle(fontSize: 12, color: Color(0xFF0F74C7))),
                SizedBox(width: 20),
                Icon(Icons.file_download, size: 16, color: Color(0xFF0F74C7)),
                SizedBox(width: 4),
                Text("Download GST",
                    style: TextStyle(fontSize: 12, color: Color(0xFF0F74C7))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
