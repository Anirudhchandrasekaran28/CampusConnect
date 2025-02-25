// import 'package:flutter/material.dart';

// class SidebarMenu extends StatelessWidget {
//   const SidebarMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: const Color(0xFFFF717A), // Sidebar Background Color
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🔹 Top Wavy Design
//             Container(
//               height: 150,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             // 🔹 Menu Options
//             _buildMenuItem("Profile"),
//             _buildMenuItem("Settings"),
//             _buildMenuItem("Navigation"),
//             _buildMenuItem("My Study Groups"),
//             _buildMenuItem("Day Planner"),

//             const Spacer(),

//             // 🔹 Email Display & Sign Out Button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "user@gmail.com",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 14,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Container(
//                       width: 25,
//                       height: 25,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close Sidebar
//                 },
//                 child: const Text(
//                   "Sign Out",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 14,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 Helper Function to Build Sidebar Menu Items
//   Widget _buildMenuItem(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontFamily: "Poppins",
//           fontSize: 18,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

import 'package:campusconnect/frontend/dayp.dart';
import 'package:campusconnect/frontend/profile.dart';
import 'package:campusconnect/frontend/stgrp.dart';
import 'package:flutter/material.dart';

import 'package:campusconnect/frontend/planner.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFFF717A), // Sidebar Background Color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Top Wavy Design
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Menu Options (Now Navigate to Pages)
            _buildMenuItem("Profile", context, const ProfilePage()),
            _buildMenuItem("Day Planner", context, DayPlannerPage()),
            _buildMenuItem("Settings", context, const DummyPage()),
            _buildMenuItem("Navigation", context, const DummyPage()),
            _buildMenuItem("My Study Groups", context, const StudyGroupsPage()),

            const Spacer(),

            // 🔹 Email Display & Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "user@gmail.com",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close Sidebar
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Helper Function to Build Sidebar Menu Items with Navigation
  Widget _buildMenuItem(String title, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dummy Page')),
      body: const Center(child: Text('Future Navigation Page')),
    );
  }
}
