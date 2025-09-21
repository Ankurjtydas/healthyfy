import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Health Education",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Prevention and awareness",
                style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search courses...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              ),
            ),
            const SizedBox(height: 12),

            // 📌 Category Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("All Topics", true, Icons.book),
                  _buildCategoryChip("Disease Prevention", false, Icons.shield),
                  _buildCategoryChip("Water Safety", false, Icons.water_drop),
                  _buildCategoryChip("Sanitation", false, Icons.clean_hands),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 📊 Learning Progress Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Learning Progress",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _progressItem("4", "Courses Started"),
                        _progressItem("1", "Completed"),
                        _progressItem("45", "Hours Learned"),
                      ],
                    ),

                    const SizedBox(height: 12),
                    const Text("Overall Progress"),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: 0.38,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(6),
                      backgroundColor: Colors.grey[300],
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 4),
                    const Text("38%",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 🏆 Recent Achievements
            const Text("Recent Achievements",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildAchievementCard("Health Guardian",
                "Completed 3 prevention courses", "Earned", true),
            _buildAchievementCard("Water Safety Expert",
                "Completed all water safety courses", "", false),
            const SizedBox(height: 16),

            // 📚 Available Courses
            const Text("Available Courses (5)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            _buildCourseCard(
              "Water Purification Methods",
              "Learn safe water treatment and purification techniques",
              "Beginner",
              "45 min",
              1234,
              4.8,
              0.65,
              true,
            ),
            _buildCourseCard(
              "Cholera Prevention & Treatment",
              "Understanding cholera symptoms, prevention and treatment.",
              "Beginner",
              "30 min",
              987,
              4.6,
              1.0,
              true,
            ),
            _buildCourseCard(
              "Hand Hygiene Best Practices",
              "Proper handwashing and hygiene maintenance.",
              "Beginner",
              "20 min",
              756,
              4.7,
              0.0,
              false,
            ),
            _buildCourseCard(
              "Diarrheal Disease Recognition",
              "Identifying symptoms and when to seek medical help.",
              "Intermediate",
              "35 min",
              2134,
              4.9,
              0.25,
              true,
            ),
            _buildCourseCard(
              "Community Health Surveillance",
              "Advanced training for health surveillance teams.",
              "Advanced",
              "90 min",
              432,
              4.5,
              0.0,
              false,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Category Chip Builder
  Widget _buildCategoryChip(String text, bool selected, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        avatar: Icon(icon, size: 18, color: selected ? Colors.white : Colors.grey),
        label: Text(text),
        selected: selected,
        selectedColor: Colors.blue,
        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
        onSelected: (_) {},
      ),
    );
  }

  // 🔹 Progress Item
// 🔹 Progress Item
  Widget _progressItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }


  // 🔹 Achievement Card
  Widget _buildAchievementCard(
      String title, String subtitle, String badge, bool earned) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.emoji_events, color: Colors.amber),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: earned
            ? Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(6)),
          child: Text(badge,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold)),
        )
            : null,
      ),
    );
  }

  // 🔹 Course Card
  Widget _buildCourseCard(
      String title,
      String description,
      String level,
      String duration,
      int learners,
      double rating,
      double progress,
      bool started) {
    Color levelColor;
    switch (level) {
      case "Beginner":
        levelColor = Colors.green;
        break;
      case "Intermediate":
        levelColor = Colors.orange;
        break;
      case "Advanced":
        levelColor = Colors.red;
        break;
      default:
        levelColor = Colors.blueGrey;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: levelColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(level,
                      style: TextStyle(
                          color: levelColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(description,
                style: const TextStyle(fontSize: 13, color: Colors.black54)),

            const SizedBox(height: 8),
            // Info Row
            Row(
              children: [
                const Icon(Icons.schedule, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(duration, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                const Icon(Icons.people, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text("$learners", style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(rating.toString(), style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),

            // Progress
            if (progress > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(6),
                    backgroundColor: Colors.grey[300],
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 4),
                  Text("${(progress * 100).toInt()}%",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            const SizedBox(height: 8),

            // Action Button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: started ? Colors.blue : Colors.grey[200],
                        foregroundColor:
                        started ? Colors.white : Colors.black87),
                    onPressed: () {},
                    icon: Icon(started ? Icons.play_arrow : Icons.play_circle),
                    label: Text(started ? "Continue" : "Start Course"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
