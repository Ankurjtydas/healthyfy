import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Offline Mode",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Access health data offline",
                style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.wifi)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Online Status
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.public, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "You are online. All features are available.",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 🔄 Data Synchronization
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Data Synchronization",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.sync),
                          label: const Text("Sync Now"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _syncItem("234 MB", "Cached Data"),
                        _syncItem("Now", "Last Sync"),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📂 Offline Data Section
            const Text("Offline Data",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildOfflineItem("Health Contacts",
                "45 items • 2.3 MB • Updated 2 hours ago", "synced"),
            _buildOfflineItem("Disease Protocols",
                "23 items • 8.7 MB • Updated 1 day ago", "synced"),
            _buildOfflineItem("Surveillance Map Data",
                "1 items • 156 MB • Updated 3 days ago", "outdated"),
            _buildOfflineItem("Health Reports (Draft)",
                "3 items • 1.2 MB • Updated 5 minutes ago", "pending"),
            _buildOfflineItem("Health Education Content",
                "12 items • 45.2 MB • Updated 1 week ago", "synced"),
            const SizedBox(height: 16),

            // ☎ Emergency Contacts
            const Text("Emergency Contacts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildContactItem("Emergency Services", "911"),
            _buildContactItem("Health Department", "(555) 123-4567"),
            _buildContactItem("Disease Control Center", "(555) 234-5678"),
            _buildContactItem("Hospital Emergency", "(555) 345-6789"),
            _buildContactItem("Water Authority", "(555) 567-8901"),
            _buildContactItem("Health Surveillance", "(555) 456-7890"),
            const SizedBox(height: 16),

            // 📌 Available Offline
            const Text("Available Offline",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.5,
              children: [
                _buildOfflineTile("Emergency Contacts", "Always available",
                    Colors.green[100]!, Colors.green),
                _buildOfflineTile("Safety Procedures", "Cached content",
                    Colors.green[100]!, Colors.green),
                _buildOfflineTile("Draft Reports", "Sync when online",
                    Colors.yellow[100]!, Colors.orange),
                _buildOfflineTile("Basic Map", "Limited features",
                    Colors.yellow[100]!, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable Widgets

  // Data sync stats
  Widget _syncItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  // Offline item row
  Widget _buildOfflineItem(String title, String subtitle, String status) {
    Color statusColor;
    switch (status) {
      case "synced":
        statusColor = Colors.green;
        break;
      case "outdated":
        statusColor = Colors.red;
        break;
      case "pending":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          status == "outdated"
              ? Icons.download
              : status == "pending"
              ? Icons.hourglass_bottom
              : Icons.refresh,
          color: statusColor,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6)),
          child: Text(status,
              style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // Emergency contact card
  Widget _buildContactItem(String name, String phone) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.phone, color: Colors.blue),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(phone),
        trailing: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue,
          ),
          onPressed: () {},
          icon: const Icon(Icons.call),
          label: const Text("Call"),
        ),
      ),
    );
  }

  // Offline tile cards
  Widget _buildOfflineTile(
      String title, String subtitle, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.8))),
        ],
      ),
    );
  }
}
