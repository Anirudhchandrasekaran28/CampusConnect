import 'package:campusconnect/frontend/alerts.dart';
import 'package:campusconnect/frontend/lib.dart';
import 'package:campusconnect/frontend/planner.dart';
import 'package:campusconnect/frontend/sidebar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CampusConnect',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const HomePage(name: "Guest", regNo: "000000"), // Default values
    );
  }
}

class HomePage extends StatefulWidget {
  final String name;
  final String regNo;

  const HomePage({super.key, required this.name, required this.regNo});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Home is initially selected
  final double navBarHeight = 50; // Adjust height here
  int _currentIndex = 0; // Track the current slide index

  final List<String> studyTips = [
    "💡 Stay organized by using a planner to track assignments and deadlines.",
    "📖 Revise actively by summarizing notes and teaching concepts to a friend.",
    "🕒 Manage time wisely by breaking study sessions into focused intervals."
  ];

  void _nextSlide() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % studyTips.length;
    });
  }

  void _previousSlide() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + studyTips.length) % studyTips.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarMenu(),
      body: Column(
        children: [
          // 🔹 Top Background Container with User's Name & Reg No
          Stack(
            children: [
              Container(
                height: 210, // Adjust height as needed
                color: const Color(0xFF363C56),
              ),
              Positioned(
                top: 30,
                left: 15,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // ✅ Open SidebarMenu
                    },
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi ${widget.name}!", // ✅ Dynamic User Name
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Reg No: ${widget.regNo}", // ✅ Dynamic Reg No
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: -15, // ✅ Align RedSmollGuy to the right corner
                child: Image.asset(
                  'assets/redsmollguy.png',
                  width: 100,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 🔹 SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 10.0), // Reduced padding
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15), // Reduced height
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 🔹 2 Tappable Images (Campus Navigation & List Service)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageTile('assets/campusnavigation.png', context),
              _buildImageTile('assets/listservice.png', context),
            ],
          ),

          const SizedBox(height: 22),

          // 🔹 Scrollable Cards
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _buildCard(
                    'assets/planner.png',
                    PlannerPage(
                      regNo: widget.regNo,
                    ),
                    context,
                    widget.regNo),
                _buildCard(
                    'assets/alerts.png', AlertsScreen(), context, widget.regNo),
                _buildCard('assets/leaderboard.png', DummyPage(), context,
                    widget.regNo),
                _buildCard(
                    'assets/tutoring.png', DummyPage(), context, widget.regNo),
              ],
            ),
          ),

          const SizedBox(height: 22), // Spacing

          // 🔹 Study Tips Box
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF363C56),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Text(
                  "Study Tips",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    studyTips[_currentIndex],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 24),
                      onPressed: _previousSlide,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 24),
                      onPressed: _nextSlide,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 0),
        ],
      ),

      // ✅ Bottom Navigation Bar with Floating Home Button
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          // Bottom Navigation Bar
          Container(
            height: navBarHeight,
            decoration: const BoxDecoration(
              color: Color(0xFFFF717A), // Background color
              borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.menu, 0),
                const SizedBox(width: 60), // Space for the home button
                _buildNavItem(Icons.person, 2),
              ],
            ),
          ),
          // Floating Home Button
          Positioned(
            top: 0,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 255, 113, 122),
              elevation: 0,
              onPressed: () => _onItemTapped(1),
              shape: const CircleBorder(),
              child: const Icon(Icons.home,
                  color: Color.fromARGB(255, 255, 255, 255), size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(icon,
          size: 30,
          color: _selectedIndex == index ? Colors.white : Colors.white70),
      onPressed: () => _onItemTapped(index),
    );
  }
}

class _onItemTapped {
  _onItemTapped(int index);
}

// Helper function to build tappable images
Widget _buildImageTile(String imagePath, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LibraryPage()),
      );
    },
    child: Image.asset(imagePath, width: 150),
  );
}

// Helper function to build scrollable cards
Widget _buildCard(String imagePath, Widget destinationPage,
    BuildContext context, String regNo) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage), // Pass regNo
      );
    },
    child: Container(
      width: 110,
      margin: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    ),
  );
}

// Dummy Page (Now Defined!)
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
