import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const AlertsScreen(),
    );
  }
}

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Status bar space

                // Back Button & Title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          size: 28, color: Colors.black),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    const Text(
                      "Alerts",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),

                const SizedBox(height: 20),

                // Alert Notifications
                AlertCard(
                  icon: Icons.call,
                  text: "Meeting with design team in 1 hour",
                ),
                AlertCard(
                  icon: Icons.notifications,
                  text: "Sc test today at 6:00 PM,\n"
                      "Don't forget to revise for it",
                ),
                AlertCard(
                  icon: Icons.calendar_today,
                  text: "Tomorrow 3 - 5 pm, club meeting\n"
                      "Don't forget to stay back in college after classes",
                ),

                const SizedBox(height: 20),

                // Announcements Section
                const Text(
                  "Announcements",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                CarouselSlider(
                  options: CarouselOptions(
                    height: 260, // *Bigger announcement card*
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.9,
                  ),
                  items: [
                    AnnouncementCard(),
                    AnnouncementCard(),
                    AnnouncementCard(),
                  ],
                ),

                const SizedBox(height: 20),

                // Homework Card
                AlertCard(
                  icon: Icons.edit,
                  text: "Math homework",
                ),
              ],
            ),
          ),

          // Mascot Bottom Right
          Positioned(
            bottom: 50,
            right: -10,
            child: Image.asset(
              "assets/cc2.png",
              height: 140, // *Slightly larger mascot*
            ),
          ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 55, // *Thin Navigation Bar*
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(icon: Icons.home, label: "Home"),
                  BottomNavItem(icon: Icons.notifications, label: "Alerts"),
                  BottomNavItem(icon: Icons.person, label: "Profile"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Notification Cards
class AlertCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const AlertCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 235, 255),
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
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Announcement Cards
// class AnnouncementCard extends StatelessWidget {
//   const AnnouncementCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.pink[50],
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.1),
//             blurRadius: 4,
//             spreadRadius: 1,
//             offset: const Offset(2, 2),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             "assets/recharge_fest.png",
//             height: 110, // *Bigger image for better visibility*
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "March 13, 14, 15",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 6),
//           const Text(
//             "Enjoy the moment,\n"
//             "but don't forget the mission\n"
//             "Stick to the schedule, stay on track,\n"
//             "and keep learning",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.blue,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.pink[50],
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
      child: SingleChildScrollView(
        // Prevents overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/recharge_fest.png",
              height: 100, // Adjusted to prevent overflow
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            const Text(
              "March 13, 14, 15",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enjoy the moment,\n"
              "but don't forget the mission\n"
              "Stick to the schedule, stay on track,\n"
              "and keep learning",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 62, 138, 201),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8), // Extra space to prevent bottom overflow
          ],
        ),
      ),
    );
  }
}

// Bottom Navigation Button Widget
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const BottomNavItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: Colors.black54),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
