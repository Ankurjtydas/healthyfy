import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import your other pages

import 'data.dart';
import 'alert.dart';
import 'map.dart';
import 'learn.dart';
import 'offline.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // ✅ Pages must match bottom nav items count (6 items)
  final List<Widget> _pages = const [
    HomeDashboard(), // dashboard content
    ReportCasePage(),
    AlertPage(),
    MapPage(),
    LearnPage(),
    OfflinePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Data"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Learn"),
          BottomNavigationBarItem(icon: Icon(Icons.wifi_off), label: "Offline"),
        ],
      ),
    );
  }
}

/// 🔹 Home dashboard content (your design)
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Blue header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Health Surveillance",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Early Warning System",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Online",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Warning alert
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Water quality alert: Avoid drinking from public wells in downtown area.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.red.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard("New Cases", "12", Icons.coronavirus, Colors.blue),
              _buildStatCard("Monitored Areas", "8", Icons.location_on, Colors.purple),
            ],
          ),

          const SizedBox(height: 20),

          // 🔹 Quick Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Quick Actions",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),

          _buildActionTile(Icons.shield_outlined, "Report Case", "Submit health data"),
          _buildActionTile(Icons.map_outlined, "Disease Map", "Outbreak locations"),
          _buildActionTile(Icons.notifications_outlined, "Health Alerts", "3 new warnings"),
          _buildActionTile(Icons.person_outline, "Health Tips", "Prevention guides"),

          const SizedBox(height: 20),

          // 🔹 Recent Activity
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Recent Activity",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),

          _buildActivityTile("Downtown Area", "Outbreak", "2 hours ago", Colors.red),
          _buildActivityTile("Riverside District", "Alert", "4 hours ago", Colors.orange),
          _buildActivityTile("Health Workshop", "Prevention", "1 day ago", Colors.green),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 🔹 Helper widget: Stats card
  static Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 10),
          Text(value,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  // 🔹 Helper widget: Quick Action tile
  static Widget _buildActionTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
      onTap: () {
        // TODO: add navigation later
      },
    );
  }

  // 🔹 Helper widget: Recent Activity tile
  static Widget _buildActivityTile(String title, String subtitle, String time, Color dotColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: dotColor, size: 12),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                Text(subtitle,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(time, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
