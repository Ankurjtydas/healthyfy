import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart'; // ⬅️ import login page for logout navigation

class AshaPortalPage extends StatefulWidget {
  const AshaPortalPage({Key? key}) : super(key: key);

  @override
  State<AshaPortalPage> createState() => _AshaPortalPageState();
}

class _AshaPortalPageState extends State<AshaPortalPage> {
  bool showNewEntryForm = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String severity = "Low";
  String waterSource = "Municipal Supply";

  // Mock data
  List<Map<String, dynamic>> patientData = [
    {
      "name": "Priya Sharma",
      "age": 28,
      "location": "Ward 12, Sector A",
      "temperature": "101.2°F",
      "water": "Municipal Supply",
      "symptoms": ["Diarrhea", "Fever"],
      "severity": "Medium",
      "notes": "Patient reports symptoms started 2 days ago",
      "date": "2024-01-15 10:30 AM",
    },
    {
      "name": "Raj Kumar",
      "age": 45,
      "location": "Ward 8, Sector B",
      "temperature": "99.8°F",
      "water": "Borewell",
      "symptoms": ["Vomiting", "Abdominal Pain"],
      "severity": "Low",
      "notes": "Mild symptoms, advised rest and ORS",
      "date": "2024-01-15 02:15 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ASHA Worker Portal",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            Text("Field Data Collection",
                style: GoogleFonts.poppins(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // 🔹 Go back to Login Page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard("Total Entries", patientData.length.toString(),
                    Icons.folder),
                _buildStatCard("Submitted", "1", Icons.check_circle),
              ],
            ),
            const SizedBox(height: 16),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  setState(() {
                    showNewEntryForm = !showNewEntryForm;
                  });
                },
                icon: const Icon(Icons.add),
                label: Text(showNewEntryForm
                    ? "Close Entry Form"
                    : "Add New Patient Data"),
              ),
            ),

            const SizedBox(height: 20),

            // If form is open
            if (showNewEntryForm) _buildNewEntryForm(),

            const SizedBox(height: 20),

            // Collected Data
            // Collected Data
            Text("Collected Data",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            Column(
              children: patientData
                  .map((data) => _buildPatientCard(data))
                  .toList(),
            ),

          ],
        ),
      ),
    );
  }

  // Stat Card
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.green, size: 28),
          const SizedBox(height: 10),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          Text(title,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Patient Card
  Widget _buildPatientCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Age + Severity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${data['name']}, ${data['age']} years",
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: data['severity'] == "High"
                      ? Colors.red.shade100
                      : data['severity'] == "Medium"
                      ? Colors.orange.shade100
                      : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(data['severity'],
                    style: TextStyle(
                        color: data['severity'] == "High"
                            ? Colors.red
                            : data['severity'] == "Medium"
                            ? Colors.orange
                            : Colors.green)),
              ),
            ],
          ),
          Text(data['location'],
              style:
              GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
          const SizedBox(height: 6),

          Row(
            children: [
              Icon(Icons.thermostat, size: 16, color: Colors.red),
              const SizedBox(width: 4),
              Text("Temp: ${data['temperature']}"),
              const SizedBox(width: 16),
              Icon(Icons.water_drop, size: 16, color: Colors.blue),
              const SizedBox(width: 4),
              Text(data['water']),
            ],
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 6,
            children: data['symptoms']
                .map<Widget>((symptom) => Chip(
              label: Text(symptom),
              backgroundColor: Colors.blue.shade50,
            ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(data['notes']),
          const SizedBox(height: 8),
          Text(data['date'],
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // New Entry Form
  Widget _buildNewEntryForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New Patient Data Entry",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),

          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Patient Name"),
          ),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(labelText: "Age"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(labelText: "Location"),
          ),
          TextField(
            controller: symptomsController,
            decoration: const InputDecoration(labelText: "Symptoms"),
          ),
          TextField(
            controller: temperatureController,
            decoration: const InputDecoration(labelText: "Temperature"),
          ),

          DropdownButtonFormField(
            value: waterSource,
            items: ["Municipal Supply", "Borewell", "Tank", "Other"]
                .map((src) =>
                DropdownMenuItem(value: src, child: Text(src)))
                .toList(),
            onChanged: (val) => setState(() => waterSource = val.toString()),
            decoration: const InputDecoration(labelText: "Water Source"),
          ),

          DropdownButtonFormField(
            value: severity,
            items: ["Low", "Medium", "High"]
                .map((sev) =>
                DropdownMenuItem(value: sev, child: Text(sev)))
                .toList(),
            onChanged: (val) => setState(() => severity = val.toString()),
            decoration: const InputDecoration(labelText: "Severity"),
          ),

          TextField(
            controller: notesController,
            decoration: const InputDecoration(labelText: "Additional Notes"),
            maxLines: 2,
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      patientData.add({
                        "name": nameController.text,
                        "age": int.tryParse(ageController.text) ?? 0,
                        "location": locationController.text,
                        "temperature": temperatureController.text,
                        "water": waterSource,
                        "symptoms": symptomsController.text.split(","),
                        "severity": severity,
                        "notes": notesController.text,
                        "date": DateTime.now().toString(),
                      });
                      showNewEntryForm = false;
                      nameController.clear();
                      ageController.clear();
                      locationController.clear();
                      symptomsController.clear();
                      temperatureController.clear();
                      notesController.clear();
                    });
                  },
                  child: const Text("Save as Draft"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      showNewEntryForm = false;
                    });
                  },
                  child: const Text("Cancel"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
