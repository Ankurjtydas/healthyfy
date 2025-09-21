import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  bool pushNotifications = true;
  bool emergencyAlerts = true;
  bool healthUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Health Alerts",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Disease surveillance notifications",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification Settings
                  Text("Notification Settings",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text("Push Notifications"),
                    value: pushNotifications,
                    onChanged: (val) =>
                        setState(() => pushNotifications = val),
                  ),
                  SwitchListTile(
                    title: const Text("Emergency Alerts"),
                    value: emergencyAlerts,
                    onChanged: (val) =>
                        setState(() => emergencyAlerts = val),
                  ),
                  SwitchListTile(
                    title: const Text("Health Updates"),
                    value: healthUpdates,
                    onChanged: (val) =>
                        setState(() => healthUpdates = val),
                  ),
                  const SizedBox(height: 20),

                  // Priority Counts
                  // 🔹 Priority Count Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildPriorityCard("2", "High Priority", Colors.red),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildPriorityCard("1", "Medium Priority", Colors.orange),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildPriorityCard("2", "Low Priority", Colors.green),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Recent Alerts
                  Text("Recent Alerts",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),

                  _buildAlertCard(
                    "Water Contamination Alert",
                    "E.coli detected in Riverside water source. Boil water before consumption.",
                    "high",
                    "5 minutes ago",
                    "Riverside District",
                  ),
                  _buildAlertCard(
                    "Cholera Outbreak Warning",
                    "3 confirmed cases reported in central market area. Practice good hygiene.",
                    "high",
                    "2 hours ago",
                    "Central Market",
                  ),
                  _buildAlertCard(
                    "Diarrheal Disease Surveillance",
                    "Increased cases of diarrheal disease in northern district under monitoring.",
                    "medium",
                    "4 hours ago",
                    "Northern District",
                  ),
                  _buildAlertCard(
                    "Water Quality Restored",
                    "Water treatment completed in affected areas. Safe for consumption.",
                    "low",
                    "6 hours ago",
                    "Downtown Area",
                  ),
                  _buildAlertCard(
                    "Health Tip of the Day",
                    "Always wash hands with soap for 20 seconds before eating.",
                    "low",
                    "1 day ago",
                    "General",
                  ),
                  const SizedBox(height: 20),

                  // Mark All as Read
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("All alerts marked as read.")),
                        );
                      },
                      child: const Text("Mark All as Read"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for priority count cards
  Widget _buildPriorityCard(String count, String label, Color color) {
    return Container(
      width: 100,
      height: 100, // keep cards same size
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 🔹 avoids overflow
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Flexible(   // 🔹 text wraps instead of overflowing
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


  // Widget for alert cards
  Widget _buildAlertCard(
      String title,
      String description,
      String priority,
      String time,
      String location,
      ) {
    Color priorityColor;
    IconData icon;

    switch (priority) {
      case "high":
        priorityColor = Colors.red;
        icon = Icons.warning_amber_rounded;
        break;
      case "medium":
        priorityColor = Colors.orange;
        icon = Icons.error_outline;
        break;
      default:
        priorityColor = Colors.green;
        icon = Icons.check_circle_outline;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: priorityColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(priority.toUpperCase(),
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: priorityColor)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(description,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 12),
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
