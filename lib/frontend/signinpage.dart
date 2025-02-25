import 'package:campusconnect/frontend/home.dart';
import 'package:campusconnect/frontend/loginpage.dart';
import 'package:campusconnect/frontend/scan.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Letter spacing control
const double kLetterSpacing = 2.4;
const double jLetterSpacing = 1.4;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();

  void _showMessage(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }

  Future<void> _registerUser() async {
    const String apiUrl = "http://192.168.137.1:5000/signup"; // API Endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "regNo": regNoController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      // ✅ Debug: Print Full API Response
      print("🔹 Raw Response Body: ${response.body}");

      final Map<String, dynamic>? responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (responseData != null && responseData.containsKey("user")) {
          // ✅ Use API response if available
          String name =
              responseData["user"]["name"] ?? nameController.text.trim();
          String regNo =
              responseData["user"]["regNo"] ?? regNoController.text.trim();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✅ User registered successfully!"),
              backgroundColor: Colors.green,
            ),
          );

          // ✅ Navigate to HomePage with user data
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(name: name, regNo: regNo)),
          );
        } else {
          // ❌ API didn't return user data, use input fields
          print("❌ Error: 'user' key missing in response. Using input values.");

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✅ User registered successfully!"),
              backgroundColor: Colors.green,
            ),
          );

          // ✅ Navigate with manually entered values
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                name: nameController.text.trim(),
                regNo: regNoController.text.trim(),
              ),
            ),
          );
        }
      } else {
        String errorMessage =
            responseData?["message"] ?? "Unexpected response error!";
        print("❌ Server Error: $errorMessage");
        _showMessage("❌ $errorMessage", Colors.red);
      }
    } catch (error) {
      print("❌ Error: $error");
      _showMessage(
          "❌ Connection Error! Check your internet & server.", Colors.red);
    }
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Please fill all the fields correctly"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Now safely call API
    _registerUser();
  }

  void _scanToContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // ✅ Prevents UI movement when keyboard opens
      backgroundColor: const Color(0xFF363C56),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: -5,
            child: Image.asset('assets/bluebigguy.png', width: 160),
          ),
          Positioned(
            top: 30,
            right: -20,
            child: Image.asset('assets/redsmollguy.png', width: 120),
          ),
          const Positioned(
            top: 40,
            left: 20,
            child: Text(
              "CampusConnect",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: kLetterSpacing,
              ),
            ),
          ),
          const Positioned(
            top: 200,
            left: 115,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  letterSpacing: jLetterSpacing,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 250,
            left: 100,
            right: 0,
            child: Text(
              "Helping you\nsmarter and\n\t\t\t\t\t\t\t\t\t\t\t\t\t\tlend with confidence!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: jLetterSpacing,
              ),
            ),
          ),
          Positioned(
            bottom: 260,
            left: 20,
            right: 20,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Name", Colors.white),
                  const SizedBox(height: 8),
                  _buildTextField(nameController, "Enter name"),
                  const SizedBox(height: 18),
                  _buildLabel("Reg no", Colors.white),
                  const SizedBox(height: 8),
                  _buildTextField(regNoController, "Enter Reg no"),
                  const SizedBox(height: 20),
                  _buildLabel("Password", Colors.white),
                  const SizedBox(height: 8),
                  _buildTextField(passwordController, "Enter password",
                      obscureText: true),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -12,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -39,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSignInButton(),
                      const SizedBox(height: 14),
                      _buildDividerWithText("or"),
                      const SizedBox(height: 15),
                      _buildScanButton(),
                      const SizedBox(height: 25),
                      _buildSignInText(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: color,
        letterSpacing: jLetterSpacing,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) => value == null || value.isEmpty
          ? "This field is required"
          : null, // ✅ Fix: Ensures validation works
    );
  }

  Widget _buildSignInButton() {
    return _buildButton(
        "Sign in", _signIn, const Color(0xFFFC7D90), Colors.white);
  }

  Widget _buildScanButton() {
    return _buildButton(
        "Scan To Continue", _scanToContinue, Colors.white, Colors.black54);
  }

  Widget _buildSignInText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      child: const Text(
        "Already have an account? Log in",
        style: TextStyle(color: Colors.blue, fontSize: 14),
      ),
    );
  }
}

Widget _buildButton(
    String text, VoidCallback onPressed, Color bgColor, Color textColor) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 14,
          spreadRadius: 4,
        ),
      ],
    ),
    child: SizedBox(
      width: 200,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            letterSpacing: jLetterSpacing,
          ),
        ),
      ),
    ),
  );
}

Widget _buildDividerWithText(String text) {
  return Row(
    children: [
      const Expanded(child: Divider(thickness: 1, color: Colors.black45)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              letterSpacing: jLetterSpacing,
              color: Colors.black87),
        ),
      ),
      const Expanded(child: Divider(thickness: 1, color: Colors.black45)),
    ],
  );
}
