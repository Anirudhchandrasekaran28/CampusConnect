// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart'; // Import for date formatting

// class PlannerPage extends StatefulWidget {
//   final String regNo; // Receive regNo

//   const PlannerPage({super.key, required this.regNo});

//   @override
//   _PlannerPageState createState() => _PlannerPageState();
// }

// class _PlannerPageState extends State<PlannerPage> {
//   DateTime _selectedDate = DateTime.now();
//   String? _selectedTime;
//   final List<String> _availableTimes = ["10 am", "11 am"];
//   final List<Map<String, String>> _events = [];
//   final TextEditingController _noteController = TextEditingController();

//   Widget _buildTimeButton(String label, {bool isAdd = false}) {
//     return GestureDetector(
//       onTap: () {
//         if (isAdd) {
//           _showTimePicker();
//         } else {
//           setState(() {
//             _selectedTime = label;
//           });
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//         decoration: BoxDecoration(
//           color: _selectedTime == label ? Colors.blue : const Color(0xFFF5F6FA),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: _selectedTime == label ? Colors.white : Colors.black),
//         ),
//       ),
//     );
//   }

//   void _showTimePicker() async {
//     TimeOfDay? picked =
//         await showTimePicker(context: context, initialTime: TimeOfDay.now());
//     if (picked != null) {
//       setState(() {
//         _selectedTime = picked.format(context);
//         _availableTimes.add(_selectedTime!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // 🔹 Header Section
//           Stack(
//             children: [
//               Container(
//                 height: 160,
//                 color: const Color(0xFFF5F6FA),
//               ),
//               Positioned(
//                 top: 50,
//                 left: 15,
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, size: 30),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//               const Positioned(
//                 top: 55,
//                 left: 70,
//                 child: Text(
//                   "Planner",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 20,
//                 right: -10,
//                 child: Image.asset('assets/redsmollguy.png', width: 110),
//               ),
//               const Positioned(
//                 top: 110,
//                 left: 20,
//                 child: Text(
//                   "Every plan is a step to success,\nstay unstoppable",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 15,
//                     color: Color(0xFF5A5D72),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 15),

//           // 🔹 Scrollable Events Section
//           SizedBox(
//             height: 170,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               children: [
//                 _buildEventCard("Meeting with design team", "Starts in 1 hour"),
//                 _buildEventCard("UI/UX Workshop", "Starts in 6 hours"),
//                 _buildEventCard("Project Deadline", "Tomorrow at 2 PM"),
//                 ..._events.map((event) =>
//                     _buildEventCard(event["title"]!, event["time"]!)),
//               ],
//             ),
//           ),

//           const SizedBox(height: 10),

//           // 🔹 Time Selector
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ..._availableTimes.map((time) => _buildTimeButton(time)),
//               _buildTimeButton("+", isAdd: true),
//             ],
//           ),

//           const SizedBox(height: 10),

//           // 🔹 Calendar Section
//           TableCalendar(
//             focusedDay: _selectedDate,
//             firstDay: DateTime.utc(2020, 1, 1),
//             lastDay: DateTime.utc(2030, 12, 31),
//             calendarFormat: CalendarFormat.month,
//             availableGestures: AvailableGestures.all,
//             headerStyle: const HeaderStyle(
//               formatButtonVisible: false,
//               titleCentered: true,
//             ),
//             calendarStyle: const CalendarStyle(
//               todayDecoration:
//                   BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
//               selectedDecoration:
//                   BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//             ),
//             selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDate = selectedDay;
//               });
//               _showAddNoteDialog(); // Show popup with selected date
//             },
//           ),

//           const SizedBox(height: 20),

//           // 🔹 Add a Note Button
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 15),
//             child: ElevatedButton(
//               onPressed: _showAddNoteDialog,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFF717A),
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Add a note",
//                     style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Event Card Widget
//   Widget _buildEventCard(String title, String time) {
//     return Container(
//       width: 180,
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFF7A93F8),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontFamily: "Poppins",
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             time,
//             style: const TextStyle(
//               fontFamily: "Poppins",
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Show Add Note Dialog
//   void _showAddNoteDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title:
//               const Text("Add Note", style: TextStyle(fontFamily: "Poppins")),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
//                 style: const TextStyle(fontFamily: "Poppins"),
//               ),
//               Text(
//                 "Time: ${_selectedTime ?? 'Not selected'}",
//                 style: const TextStyle(fontFamily: "Poppins"),
//               ),
//               TextField(
//                 controller: _noteController,
//                 decoration: const InputDecoration(
//                   hintText: "Enter Note",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child:
//                   const Text("Cancel", style: TextStyle(fontFamily: "Poppins")),
//             ),
//             TextButton(
//               onPressed: () {
//                 _addEvent();
//                 Navigator.pop(context);
//               },
//               child:
//                   const Text("Save", style: TextStyle(fontFamily: "Poppins")),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // 🔹 Save Event to List
//   void _addEvent() {
//     if (_noteController.text.isEmpty || _selectedTime == null) return;

//     int hoursLeft = DateTime.now().difference(_selectedDate).inHours.abs();

//     setState(() {
//       _events.add({
//         "title": _noteController.text,
//         "time": "Starts in $hoursLeft hours",
//       });
//       _noteController.clear();
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class PlannerPage extends StatefulWidget {
  final String regNo; // Receive regNo

  const PlannerPage({super.key, required this.regNo});

  @override
  _PlannerPageState createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  final List<String> _availableTimes = ["10 am", "11 am"];
  final List<Map<String, String>> _events = [];
  final TextEditingController _noteController = TextEditingController();

  Widget _buildTimeButton(String label, {bool isAdd = false}) {
    return GestureDetector(
      onTap: () {
        if (isAdd) {
          _showTimePicker();
        } else {
          setState(() {
            _selectedTime = label;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: _selectedTime == label ? Colors.blue : const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _selectedTime == label ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  void _showTimePicker() async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
        _availableTimes.add(_selectedTime!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header Section
          Stack(
            children: [
              Container(
                height: 160,
                color: const Color(0xFFF5F6FA),
              ),
              Positioned(
                top: 50,
                left: 15,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const Positioned(
                top: 55,
                left: 70,
                child: Text(
                  "Planner",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: -10,
                child: Image.asset('assets/redsmollguy.png', width: 110),
              ),
              const Positioned(
                top: 110,
                left: 20,
                child: Text(
                  "Every plan is a step to success,\nstay unstoppable",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Color(0xFF5A5D72),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // 🔹 Scrollable Events Section
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildEventCard("Meeting with design team", "Starts in 1 hour"),
                _buildEventCard("UI/UX Workshop", "Starts in 6 hours"),
                _buildEventCard("Project Deadline", "Tomorrow at 2 PM"),
                ..._events.map((event) =>
                    _buildEventCard(event["title"]!, event["time"]!)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 Time Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._availableTimes.map((time) => _buildTimeButton(time)),
              _buildTimeButton("+", isAdd: true),
            ],
          ),

          const SizedBox(height: 10),

          // 🔹 Calendar Section
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.all,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              selectedDecoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            ),
            selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
              _showAddNoteDialog(); // Show popup with selected date
            },
          ),

          const SizedBox(height: 20),

          // 🔹 Add a Note Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: _showAddNoteDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF717A),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add a note",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Event Card Widget
  Widget _buildEventCard(String title, String time) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF7A93F8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Show Add Note Dialog
  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text("Add Note", style: TextStyle(fontFamily: "Poppins")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                style: const TextStyle(fontFamily: "Poppins"),
              ),
              Text(
                "Time: ${_selectedTime ?? 'Not selected'}",
                style: const TextStyle(fontFamily: "Poppins"),
              ),
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: "Enter Note",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Cancel", style: TextStyle(fontFamily: "Poppins")),
            ),
            TextButton(
              onPressed: () {
                _addEvent();
                Navigator.pop(context);
              },
              child:
                  const Text("Save", style: TextStyle(fontFamily: "Poppins")),
            ),
          ],
        );
      },
    );
  }

  // 🔹 Save Event to List
  void _addEvent() {
    if (_noteController.text.isEmpty || _selectedTime == null) return;

    int hoursLeft = DateTime.now().difference(_selectedDate).inHours.abs();

    setState(() {
      _events.add({
        "title": _noteController.text,
        "time": "Starts in $hoursLeft hours",
      });
      _noteController.clear();
    });
  }
}
