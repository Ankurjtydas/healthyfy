import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCasePage extends StatefulWidget {
  const ReportCasePage({Key? key}) : super(key: key);

  @override
  State<ReportCasePage> createState() => _ReportCasePageState();
}

class _ReportCasePageState extends State<ReportCasePage> {
  String? selectedDisease;
  String severity = "Low";
  bool consulted = false;
  bool labTests = false;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
                      "Report Health Case",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Submit health surveillance data",
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

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Health Case Details",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 16),

                  // Disease Type Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedDisease,
                    hint: const Text("Select disease type"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: ["Flu", "COVID-19", "Malaria", "Dengue"]
                        .map((disease) => DropdownMenuItem(
                      value: disease,
                      child: Text(disease),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDisease = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Severity
                  Text("Severity Level", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text("Low"),
                        selected: severity == "Low",
                        selectedColor: Colors.green.shade100,
                        onSelected: (_) => setState(() => severity = "Low"),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text("Medium"),
                        selected: severity == "Medium",
                        selectedColor: Colors.orange.shade100,
                        onSelected: (_) => setState(() => severity = "Medium"),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text("High"),
                        selected: severity == "High",
                        selectedColor: Colors.red.shade100,
                        onSelected: (_) => setState(() => severity = "High"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Location
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: "Location",
                      hintText: "Enter location or address",
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        locationController.text = "Current Location (GPS)";
                      });
                    },
                    icon: const Icon(Icons.my_location),
                    label: const Text("Use Current Location"),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  TextField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Describe symptoms and circumstances...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Checkboxes
                  CheckboxListTile(
                    title: const Text("Healthcare provider consulted"),
                    value: consulted,
                    onChanged: (val) => setState(() => consulted = val ?? false),
                  ),
                  CheckboxListTile(
                    title: const Text("Lab tests conducted"),
                    value: labTests,
                    onChanged: (val) => setState(() => labTests = val ?? false),
                  ),
                  const SizedBox(height: 16),

                  // Attachments
                  Text("Attachments", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Pick photo
                          },
                          icon: const Icon(Icons.photo_camera),
                          label: const Text("Photo"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Pick file
                          },
                          icon: const Icon(Icons.attach_file),
                          label: const Text("File"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        debugPrint("Disease: $selectedDisease");
                        debugPrint("Severity: $severity");
                        debugPrint("Location: ${locationController.text}");
                        debugPrint("Description: ${descriptionController.text}");
                        debugPrint("Consulted: $consulted");
                        debugPrint("Lab Tests: $labTests");
                      },
                      icon: const Icon(Icons.send),
                      label: const Text("Submit Report"),
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
}
