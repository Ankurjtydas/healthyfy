
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'asha.dart';           // exposes class AshaPortalPage
import 'health.dart';         // exposes class HealthOfficerPage
import 'home.dart';           // exposes class HomePage
import 'data.dart';
import 'map.dart';
import 'learn.dart';
import 'offline.dart';

enum LoginRole { regular, asha, officer }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPasswordVisible = false;

  LoginRole _selectedRole = LoginRole.regular; // Default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with hamburger that opens the Drawer
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      // Drawer with role selection
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer header
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue[100],
                    child: const Icon(Icons.health_and_safety,
                        color: Colors.red, size: 30),
                  ),
                  const SizedBox(height: 10),
                  Text("Health Surveillance",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  Text("Select Login Type",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),

            // Role options
            _buildRoleTile(
              role: LoginRole.regular,
              icon: Icons.person_outline,
              title: "Regular User",
              subtitle: "Community member access",
            ),
            _buildRoleTile(
              role: LoginRole.asha,
              icon: Icons.health_and_safety,
              title: "ASHA Worker",
              subtitle: "Field health worker portal",
            ),
            _buildRoleTile(
              role: LoginRole.officer,
              icon: Icons.shield_outlined,
              title: "Health Officer",
              subtitle: "Administrative access",
            ),
          ],
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: _buildLoginForm(), // dynamic form based on selected role
        ),
      ),
    );
  }

  /// Drawer option tile
  Widget _buildRoleTile({
    required LoginRole role,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedRole == role;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
      title: Text(title,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.blue : Colors.black)),
      subtitle: Text(subtitle,
          style: GoogleFonts.poppins(
              fontSize: 13,
              color: isSelected ? Colors.blue : Colors.grey)),
      selected: isSelected,
      selectedTileColor: Colors.blue[50],
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
        Navigator.pop(context); // close drawer
      },
    );
  }

  /// Build login form that changes text based on selected role
  Widget _buildLoginForm() {
    String title, subtitle, emailHint, buttonText;

    switch (_selectedRole) {
      case LoginRole.regular:
        title = "Health Surveillance";
        subtitle = "Smart Health Monitoring System";
        emailHint = "Enter your email";
        buttonText = "Sign In";
        break;
      case LoginRole.asha:
        title = "ASHA Worker Login";
        subtitle = "Accredited Social Health Activist Portal";
        emailHint = "Enter your ASHA ID or email";
        buttonText = "Sign In as ASHA Worker";
        break;
      case LoginRole.officer:
        title = "Health Officer Login";
        subtitle = "District Health Officer Portal";
        emailHint = "Enter your Officer ID or email";
        buttonText = "Sign In as Health Officer";
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue[100],
          child:
          const Icon(Icons.health_and_safety, color: Colors.red, size: 40),
        ),
        const SizedBox(height: 20),

        // Titles
        Text(title,
            style:
            GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        Text(subtitle,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 30),

        // Email / ID
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: emailHint,
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Password
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Remember me + Forgot password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),
                const Text("Remember me"),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot password?"),
            )
          ],
        ),

        const SizedBox(height: 10),

        // ✅ Correct Sign In button with role-based navigation
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              debugPrint("Role: $_selectedRole");
              debugPrint("Email: ${emailController.text}");
              debugPrint("Password: ${passwordController.text}");
              debugPrint("Remember me: $rememberMe");

              // choose destination page by role
              Widget nextPage;
              switch (_selectedRole) {
                case LoginRole.regular:
                  nextPage = const HomePage();
                  break;
                case LoginRole.asha:
                  nextPage = const AshaPortalPage(); // from asha.dart
                  break;
                case LoginRole.officer:
                  nextPage = const HealthOfficerPage(); // from health.dart ✅
                  break;
              }

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            },
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Divider + social buttons + signup
        Row(
          children: const [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR CONTINUE WITH"),
            ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.g_mobiledata, size: 28),
              label: const Text("Google"),
            ),
            const SizedBox(width: 15),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.facebook, size: 28),
              label: const Text("Facebook"),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {},
              child: const Text("Sign up"),
            )
          ],
        ),
      ],
    );
  }
}
