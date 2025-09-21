import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Map", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Track outbreaks and health data",
                style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Search + Filter section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search locations...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: "All Diseases",
                    items: const [
                      DropdownMenuItem(value: "All Diseases", child: Text("All Diseases")),
                      DropdownMenuItem(value: "Cholera", child: Text("Cholera")),
                      DropdownMenuItem(value: "E.coli", child: Text("E.coli")),
                    ],
                    onChanged: (val) {},
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
            ),

            // 🌍 Map placeholder (fixed height so no overflow)
            Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      "Disease Surveillance Map\nLive outbreak markers would appear here",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),

            // 📋 Recent Cases section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Recent Cases (4)",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildCaseCard("Cholera Outbreak", "Central Market Area", "2 hours ago", "active"),
                  _buildCaseCard("Diarrheal Cases", "North District", "6 hours ago", "active"),
                  _buildCaseCard("Water Contamination", "Riverside", "1 day ago", "resolved"),
                  _buildCaseCard("Health Advisory", "Downtown", "2 days ago", "active"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Helper method placed here properly
  Widget _buildCaseCard(String title, String location, String time, String status) {
    Color statusColor = status == "active" ? Colors.green : Colors.grey;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.red),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$location • $time"),
        trailing: Text(
          status,
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
