import 'package:flutter/material.dart';

class StudyGroupsPage extends StatelessWidget {
  const StudyGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Global font set to Poppins
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header Section
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D3142), // Dark blue background
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),

                // Back Button
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 28),
                    onPressed: () {
                      // Handle back navigation
                      Navigator.pop(context);
                    },
                  ),
                ),

                // Title Positioned Below Back Button and Centered
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Study groups",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Join any group that sparks your interest",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                // Mascot Image (Bigger & Attached to the Right)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/cc2.png",
                    height: 120, // Increased size
                    fit: BoxFit.cover, // Ensures no spacing
                  ),
                ),
              ],
            ),

            // Study Groups List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    StudyGroupCard("Computer Science Group"),
                    StudyGroupCard("Bio - Tech Group"),
                    StudyGroupCard("Flutter group"),
                    StudyGroupCard("Mongo DB Group"),
                    StudyGroupCard("Women Coders"),
                    StudyGroupCard("Coders Community"),
                    StudyGroupCard("Networking"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Study Group Card Widget
class StudyGroupCard extends StatelessWidget {
  final String groupName;

  const StudyGroupCard(this.groupName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Icon
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black54, width: 1.5),
            ),
          ),
          const SizedBox(width: 12),

          // Group Name
          Expanded(
            child: Text(
              groupName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),

          // Plus Button
          IconButton(
            icon: const Icon(Icons.add, size: 24),
            onPressed: () {
              // Handle group join action
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CodersCommunityScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CodersCommunityScreen extends StatelessWidget {
  const CodersCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Space for status bar

                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 28, color: Colors.black),
                  onPressed: () {
                    // Handle back action
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 20), // Space before title

                // Title
                const Text(
                  "Join Our Coders\nCommunity",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12), // Space before subtitle

                // Subtitle
                const Text(
                  "Where Innovation Meets Collaboration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 10), // Space before description

                // Description Text
                const Text(
                  "The Coders Community is a dynamic hub designed for university students passionate about coding, problem-solving, and technology.\n\n"
                  "It's a space where beginners and experts come together to learn, collaborate, and build innovative projects.\n\n"
                  "Meet people that make you want to achieve.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5, // Line height
                  ),
                ),

                const SizedBox(height: 20), // Space before button

                // Join Group Button
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: const Offset(2, 2),
                        )
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Handle Join Group action
                      },
                      child: const Text(
                        "Join Group",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Mascot Top-Right
          Positioned(
            top: -20,
            right: -10,
            child: Image.asset(
              "assets/cc2.png",
              height: 120,
            ),
          ),

          // Mascot Bottom-Left
          Positioned(
            bottom: -10,
            left: -20,
            child: Image.asset(
              "assets/cc1.png",
              height: 130,
            ),
          ),
        ],
      ),
    );
  }
}
