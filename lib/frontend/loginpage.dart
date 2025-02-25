// import 'package:campusconnect/frontend/scan.dart';
// import 'package:campusconnect/frontend/signinpage.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Letter spacing control
// const double kLetterSpacing = 2.4;
// const double jLetterSpacing = 1.4;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController regNoController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   String? loginMessage; // ✅ Store login message

//   Future<void> _loginUser() async {
//     const String apiUrl = "http://192.168.137.1:5000/login"; // API URL

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "regNo": regNoController.text.trim(),
//           "password": passwordController.text.trim(),
//         }),
//       );

//       final responseData = jsonDecode(response.body);
//       print("🔹 Server Response: $responseData"); // ✅ Debugging

//       setState(() {
//         if (response.statusCode == 200) {
//           loginMessage = "✅ Welcome, ${responseData["user"]["name"]}!";
//         } else {
//           loginMessage = "❌ ${responseData["message"]}";
//         }
//       });
//     } catch (error) {
//       print("❌ Error: $error"); // ✅ Debugging
//       setState(() {
//         loginMessage = "❌ Connection Error! Check your internet & server.";
//       });
//     }
//   }

//   void _login() {
//     if (!_formKey.currentState!.validate()) {
//       setState(() {
//         loginMessage = "❌ Please fill all fields correctly";
//       });
//       return;
//     }
//     _loginUser();
//   }

//   void _scanToContinue() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ScanPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false, // ✅ Prevents UI from moving up
//       backgroundColor: const Color(0xFF363C56),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height:
//               MediaQuery.of(context).size.height, // ✅ Fix for hit test error
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 130,
//                 left: -20,
//                 child: Image.asset('assets/yellowbigguy.png', width: 180),
//               ),
//               Positioned(
//                 top: 30,
//                 right: -20,
//                 child: Image.asset('assets/redsmollguy.png', width: 120),
//               ),
//               const Positioned(
//                 top: 40,
//                 left: 20,
//                 child: Text(
//                   "CampusConnect",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 30,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white,
//                     letterSpacing: kLetterSpacing,
//                   ),
//                 ),
//               ),
//               const Positioned(
//                 top: 245,
//                 left: 115,
//                 right: 0,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Log in",
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 36,
//                       fontWeight: FontWeight.w300,
//                       color: Colors.white,
//                       letterSpacing: jLetterSpacing,
//                     ),
//                   ),
//                 ),
//               ),
//               const Positioned(
//                 top: 290,
//                 left: 100,
//                 right: 0,
// child: Text(
//   "Helping you\nsmarter and\n\t\t\t\t\t\t\t\t\t\t\t\t\t\tlend with confidence!",
//   textAlign: TextAlign.center,
//   style: TextStyle(
//     fontFamily: "Poppins",
//     fontSize: 12,
//     fontWeight: FontWeight.w300,
//     color: Colors.white,
//     letterSpacing: jLetterSpacing,
//   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 275,
//                 left: 20,
//                 right: 20,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel("Reg no", Colors.white),
//                       const SizedBox(height: 8),
//                       _buildTextField(regNoController, "Enter Reg no"),
//                       const SizedBox(height: 22),
//                       _buildLabel("Password", Colors.white),
//                       const SizedBox(height: 8),
//                       _buildTextField(passwordController, "Enter password",
//                           obscureText: true),
//                     ],
//                   ),
//                 ),
//               ),

//               // White box with shadow transition falling on it
//               Positioned(
//                 bottom: -12,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 2, vertical: 30),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(0)),
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         top: -39,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 25,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 3,
//                                 spreadRadius: 1,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           _buildLoginButton(),
//                           const SizedBox(height: 15),
//                           _buildDividerWithText("or"),
//                           const SizedBox(height: 15),
//                           _buildScanButton(),
//                           const SizedBox(height: 25),
//                           _buildSignUpText(),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text, Color color) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontFamily: "Poppins",
//         fontSize: 18,
//         fontWeight: FontWeight.w400,
//         color: color,
//         letterSpacing: jLetterSpacing,
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String hintText,
//       {bool obscureText = false}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//       validator: (value) => value == null || value.isEmpty
//           ? "This field is required"
//           : null, // ✅ Fix: Ensures validation works
//     );
//   }

//   Widget _buildLoginButton() {
//     return _buildButton(
//         "Log in", _login, const Color(0xFFFC7D90), Colors.white);
//   }

//   Widget _buildScanButton() {
//     return _buildButton(
//         "Scan To Continue", _scanToContinue, Colors.white, Colors.black54);
//   }

//   Widget _buildSignUpText() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const SignInScreen()),
//         );
//       },
//       child: RichText(
//         text: const TextSpan(
//           text: "Don't have an account? ",
//           style: TextStyle(
//             fontFamily: "Poppins",
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: Colors.black54,
//           ),
//           children: [
//             TextSpan(
//               text: "Sign in",
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.blue,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen {}

// Widget _buildDividerWithText(String text) {
//   return Row(
//     children: [
//       const Expanded(child: Divider(thickness: 1, color: Colors.black45)),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Text(
//           text,
//           style: const TextStyle(
//               fontFamily: "Poppins",
//               fontSize: 14,
//               letterSpacing: jLetterSpacing,
//               color: Colors.black87),
//         ),
//       ),
//       const Expanded(child: Divider(thickness: 1, color: Colors.black45)),
//     ],
//   );
// }

// Widget _buildButton(
//     String text, VoidCallback onPressed, Color bgColor, Color textColor) {
//   return Container(
//     decoration: BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.3),
//           blurRadius: 14,
//           spreadRadius: 4,
//         ),
//       ],
//     ),
//     child: SizedBox(
//       width: 200,
//       height: 45,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: bgColor,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontFamily: "Poppins",
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: textColor,
//             letterSpacing: jLetterSpacing,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// import 'package:campusconnect/frontend/home.dart';
// import 'package:campusconnect/frontend/scan.dart';
// import 'package:campusconnect/frontend/signinpage.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// // Letter spacing control
// const double kLetterSpacing = 2.4;
// const double jLetterSpacing = 1.4;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController regNoController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> _loginUser() async {
//     const String apiUrl = "http://192.168.137.1:5000/login";

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "regNo": regNoController.text.trim(),
//           "password": passwordController.text.trim(),
//         }),
//       );

//       final responseData = jsonDecode(response.body);
//       print("🔹 Server Response: $responseData");

//       setState(() {
//         _isLoading = false;
//       });

//       if (response.statusCode == 200) {
//         String name = responseData["user"]["name"];
//         String regNo = responseData["user"]["regNo"];

//         // ✅ Navigate to HomeScreen with User Data
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(name: name, regNo: regNo),
//           ),
//         );
//       } else {
//         _showMessage("❌ ${responseData["message"]}", Colors.red);
//       }
//     } catch (error) {
//       print("❌ Error: $error");
//       setState(() {
//         _isLoading = false;
//       });
//       _showMessage(
//           "❌ Connection Error! Check your internet & server.", Colors.red);
//     }
//   }

//   void _login() {
//     if (!_formKey.currentState!.validate()) {
//       _showMessage("❌ Please fill all fields correctly", Colors.red);
//       return;
//     }
//     _loginUser();
//   }

//   void _scanToContinue() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ScanPage()),
//     );
//   }

//   void _showMessage(String message, Color bgColor) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: bgColor,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xFF363C56),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 130,
//                 left: -20,
//                 child: Image.asset('assets/yellowbigguy.png', width: 180),
//               ),
//               Positioned(
//                 top: 30,
//                 right: -20,
//                 child: Image.asset('assets/redsmollguy.png', width: 120),
//               ),
//               const Positioned(
//                 top: 40,
//                 left: 20,
//                 child: Text(
//                   "CampusConnect",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 30,
//                     fontWeight: FontWeight.w300,
//                     color: Colors.white,
//                     letterSpacing: kLetterSpacing,
//                   ),
//                 ),
//               ),
//               const Positioned(
//                 top: 245,
//                 left: 115,
//                 right: 0,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Log in",
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 36,
//                       fontWeight: FontWeight.w300,
//                       color: Colors.white,
//                       letterSpacing: jLetterSpacing,
//                     ),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: 275,
//                 left: 20,
//                 right: 20,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildLabel("Reg no", Colors.white),
//                       const SizedBox(height: 8),
//                       _buildTextField(regNoController, "Enter Reg no"),
//                       const SizedBox(height: 22),
//                       _buildLabel("Password", Colors.white),
//                       const SizedBox(height: 8),
//                       _buildTextField(passwordController, "Enter password",
//                           obscureText: true),
//                     ],
//                   ),
//                 ),
//               ),

//               // ✅ White box with buttons (unchanged)
//               Positioned(
//                 bottom: -12,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 2, vertical: 30),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(0)),
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         top: -39,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 25,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 3,
//                                 spreadRadius: 1,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           _isLoading
//                               ? const CircularProgressIndicator()
//                               : _buildLoginButton(),
//                           const SizedBox(height: 15),
//                           _buildDividerWithText("or"),
//                           const SizedBox(height: 15),
//                           _buildScanButton(),
//                           const SizedBox(height: 25),
//                           _buildSignUpText(),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text, Color color) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontFamily: "Poppins",
//         fontSize: 18,
//         fontWeight: FontWeight.w400,
//         color: color,
//         letterSpacing: jLetterSpacing,
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String hintText,
//       {bool obscureText = false}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//       validator: (value) =>
//           value == null || value.isEmpty ? "This field is required" : null,
//     );
//   }

//   Widget _buildLoginButton() {
//     return _buildButton(
//         "Log in", _login, const Color(0xFFFC7D90), Colors.white);
//   }

//   Widget _buildScanButton() {
//     return _buildButton(
//         "Scan To Continue", _scanToContinue, Colors.white, Colors.black54);
//   }

//   Widget _buildSignUpText() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const SignInScreen()),
//         );
//       },
//       child: const Text(
//         "Don't have an account? Sign up",
//         style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
//       ),
//     );
//   }
// }

// Widget _buildButton(
//     String text, VoidCallback onPressed, Color bgColor, Color textColor) {
//   return Container(
//     decoration: BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.3),
//           blurRadius: 14,
//           spreadRadius: 4,
//         ),
//       ],
//     ),
//     child: SizedBox(
//       width: 200,
//       height: 45,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: bgColor,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontFamily: "Poppins",
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: textColor,
//             letterSpacing: jLetterSpacing,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildDividerWithText(String text) {
//   return Row(
//     children: [
//       const Expanded(child: Divider(thickness: 1, color: Colors.black45)),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Text(
//           text,
//           style: const TextStyle(
//               fontFamily: "Poppins",
//               fontSize: 14,
//               letterSpacing: jLetterSpacing,
//               color: Colors.black87),
//         ),
//       ),
//       const Expanded(child: Divider(thickness: 1, color: Colors.black45)),
//     ],
//   );
// }

import 'package:campusconnect/frontend/home.dart';
import 'package:campusconnect/frontend/scan.dart';
import 'package:campusconnect/frontend/signinpage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Letter spacing control
const double kLetterSpacing = 2.4;
const double jLetterSpacing = 1.4;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    const String apiUrl = "http://192.168.137.1:5000/login";

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "regNo": regNoController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final responseData = jsonDecode(response.body);
      print("🔹 Server Response: $responseData");

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        String name = responseData["user"]["name"];
        String regNo = responseData["user"]["regNo"];

        // ✅ Navigate to HomeScreen with User Data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(name: name, regNo: regNo),
          ),
        );
      } else {
        _showMessage("❌ ${responseData["message"]}", Colors.red);
      }
    } catch (error) {
      print("❌ Error: $error");
      setState(() {
        _isLoading = false;
      });
      _showMessage(
          "❌ Connection Error! Check your internet & server.", Colors.red);
    }
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      _showMessage("❌ Please fill all fields correctly", Colors.red);
      return;
    }
    _loginUser();
  }

  void _scanToContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScanPage()),
    );
  }

  void _showMessage(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF363C56),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 130,
                left: -20,
                child: Image.asset('assets/yellowbigguy.png', width: 180),
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
                top: 245,
                left: 115,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
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
              // ✅ Added the missing text below "Log in"
              const Positioned(
                top: 290,
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
                bottom: 275,
                left: 20,
                right: 20,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Reg no", Colors.white),
                      const SizedBox(height: 8),
                      _buildTextField(regNoController, "Enter Reg no"),
                      const SizedBox(height: 22),
                      _buildLabel("Password", Colors.white),
                      const SizedBox(height: 8),
                      _buildTextField(passwordController, "Enter password",
                          obscureText: true),
                    ],
                  ),
                ),
              ),

              // ✅ White box with buttons (unchanged)
              Positioned(
                bottom: -12,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(0)),
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
                          _isLoading
                              ? const CircularProgressIndicator()
                              : _buildLoginButton(),
                          const SizedBox(height: 15),
                          _buildDividerWithText("or"),
                          const SizedBox(height: 15),
                          _buildScanButton(),
                          const SizedBox(height: 25),
                          _buildSignUpText(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
      validator: (value) =>
          value == null || value.isEmpty ? "This field is required" : null,
    );
  }

  Widget _buildLoginButton() {
    return _buildButton(
        "Log in", _login, const Color(0xFFFC7D90), Colors.white);
  }

  Widget _buildScanButton() {
    return _buildButton(
        "Scan To Continue", _scanToContinue, Colors.white, Colors.black54);
  }

  Widget _buildSignUpText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      },
      child: const Text(
        "Don't have an account? Sign up",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
      ),
    );
  }
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
