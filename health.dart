import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'login_page.dart';

class HealthOfficerPage extends StatefulWidget {
  const HealthOfficerPage({Key? key}) : super(key: key);

  @override
  State<HealthOfficerPage> createState() => _HealthOfficerPageState();
}

class _HealthOfficerPageState extends State<HealthOfficerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock case data
  final List<Map<String, dynamic>> cases = [
    {
      "name": "Priya Sharma",
      "age": 28,
      "severity": "medium",
      "status": "Pending Review",
      "asha": "Sunita Devi",
      "location": "Ward 12, Sector A",
      "temperature": "101.2°F",
      "water": "Municipal Supply",
      "symptoms": ["Diarrhea", "Fever"],
      "date": "2024-01-15 10:30 AM",
    },
    {
      "name": "Raj Kumar",
      "age": 45,
      "severity": "low",
      "status": "Reviewed",
      "asha": "Meera Patel",
      "location": "Ward 8, Sector B",
      "temperature": "99.8°F",
      "water": "Borewell",
      "symptoms": ["Vomiting", "Abdominal Pain"],
      "date": "2024-01-15 02:15 PM",
    },
    {
      "name": "Amit Verma",
      "age": 35,
      "severity": "high",
      "status": "Action Required",
      "asha": "Kavita Singh",
      "location": "Ward 5, Sector C",
      "temperature": "102.5°F",
      "water": "Hand Pump",
      "symptoms": ["Fever", "Nausea", "Dehydration"],
      "date": "2024-01-15 04:45 PM",
    },
    {
      "name": "Lakshmi Reddy",
      "age": 32,
      "severity": "low",
      "status": "Pending Review",
      "asha": "Sunita Devi",
      "location": "Ward 12, Sector A",
      "temperature": "98.6°F",
      "water": "Municipal Supply",
      "symptoms": ["Stomach Pain"],
      "date": "2024-01-15 06:20 PM",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Health Officer Dashboard",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Text(
              "District Health Monitoring",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Case Management"),
            Tab(text: "Analytics"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCaseManagement(),
          _buildAnalytics(),
        ],
      ),
    );
  }

  /// ==========================
  /// CASE MANAGEMENT TAB
  /// ==========================
  Widget _buildCaseManagement() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: cases.map((data) => _buildCaseCard(data)).toList(),
    );
  }

  Widget _buildCaseCard(Map<String, dynamic> data) {
    Color sevColor;
    if (data['severity'] == "high") {
      sevColor = Colors.red;
    } else if (data['severity'] == "medium") {
      sevColor = Colors.orange;
    } else {
      sevColor = Colors.green;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data['name']}, ${data['age']} years",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Chip(
                  label: Text(data['severity']),
                  backgroundColor: sevColor.withOpacity(0.2),
                  labelStyle: TextStyle(color: sevColor),
                ),
              ],
            ),

            Text(
              "Reported by: ${data['asha']}",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 4),

            Text(
              data['location'],
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Vital info row
            Row(
              children: [
                const Icon(Icons.thermostat, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Text("Temp: ${data['temperature']}"),
                const SizedBox(width: 20),
                const Icon(Icons.water_drop, size: 16, color: Colors.blue),
                const SizedBox(width: 4),
                Text(data['water']),
              ],
            ),
            const SizedBox(height: 10),

            // Symptoms chips
            Wrap(
              spacing: 6,
              children: data['symptoms']
                  .map<Widget>(
                    (s) => Chip(
                  label: Text(s),
                  backgroundColor: Colors.blue.shade50,
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 10),

            Text(
              data['date'],
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text("View Details"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      data['status'] = "Reviewed";
                    });
                  },
                  child: Text(data['status']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ==========================
  /// ANALYTICS TAB
  /// ==========================
  Widget _buildAnalytics() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cases by Ward
          Text(
            "Cases by Ward",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 220, child: _WardBarChart()),

          const SizedBox(height: 24),

          // Severity Pie
          Text(
            "Severity Distribution",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 300, child: _SeverityPieChart()),
          const SizedBox(height: 12),
          const SeverityLegend(),

          const SizedBox(height: 24),

          // Export buttons
          Text(
            "Export Data",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.download),
            label: const Text("Export Cases Report (CSV)"),
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.download),
            label: const Text("Export Analytics Report (PDF)"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/// ==========================
/// BAR CHART
/// ==========================
class _WardBarChart extends StatelessWidget {
  const _WardBarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (val, _) {
                switch (val.toInt()) {
                  case 0:
                    return const Text("Ward 5");
                  case 1:
                    return const Text("Ward 8");
                  case 2:
                    return const Text("Ward 12");
                  case 3:
                    return const Text("Ward 15");
                  case 4:
                    return const Text("Ward 20");
                }
                return const Text("");
              },
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [BarChartRodData(fromY: 0, toY: 12, color: Colors.green)],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [BarChartRodData(fromY: 0, toY: 8, color: Colors.green)],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [BarChartRodData(fromY: 0, toY: 15, color: Colors.green)],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [BarChartRodData(fromY: 0, toY: 6, color: Colors.green)],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [BarChartRodData(fromY: 0, toY: 9, color: Colors.green)],
          ),
        ],
      ),
    );
  }
}

/// ==========================
/// PIE CHART
/// ==========================
class _SeverityPieChart extends StatelessWidget {
  const _SeverityPieChart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 280,
        width: 280,
        child: PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 50,
            sections: [
              PieChartSectionData(
                value: 45,
                color: Colors.green,
                title: "Low\n45%",
                radius: 75,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                titlePositionPercentageOffset: 0.55,
              ),
              PieChartSectionData(
                value: 30,
                color: Colors.orange,
                title: "Medium\n30%",
                radius: 75,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                titlePositionPercentageOffset: 0.55,
              ),
              PieChartSectionData(
                value: 25,
                color: Colors.red,
                title: "High\n25%",
                radius: 75,
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                titlePositionPercentageOffset: 0.55,
              ),
            ],
            pieTouchData: PieTouchData(enabled: false),
          ),
        ),
      ),
    );
  }
}

/// ==========================
/// LEGEND
/// ==========================
class SeverityLegend extends StatelessWidget {
  const SeverityLegend();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _LegendItem(color: Colors.green, text: "Low: 45%"),
        SizedBox(height: 6),
        _LegendItem(color: Colors.orange, text: "Medium: 30%"),
        SizedBox(height: 6),
        _LegendItem(color: Colors.red, text: "High: 25%"),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
