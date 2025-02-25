import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library Management',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const LibraryPage(),
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Book> _borrowedBooks = [];
  List<Book> _availableBooks = [
    Book("Flutter Development", "John Doe"),
    Book("Artificial Intelligence", "Andrew Ng"),
    Book("Data Science with Python", "Jake Vanderplas"),
    Book("The Pragmatic Programmer", "David Thomas"),
  ];
  Book? _selectedBook; // Stores the selected book for borrowing
  DateTime? _selectedReturnDate;

  void _borrowBook() {
    if (_selectedBook != null && _selectedReturnDate != null) {
      setState(() {
        _selectedBook!.borrowDate = DateTime.now();
        _selectedBook!.returnDate = _selectedReturnDate!;
        _borrowedBooks.add(_selectedBook!);
        _availableBooks.remove(_selectedBook!);
        _selectedBook = null;
        _selectedReturnDate = null;
      });
    }
  }

  void _returnBook(Book book) {
    setState(() {
      _borrowedBooks.remove(book);
      _availableBooks.add(book);
    });
  }

  void _selectReturnDate(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 📌 Logo on Top Right
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/cc4.png',
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          // 📌 Main Content
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 📌 Title: Library Management
                  const Text(
                    "Library Management",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationThickness: 2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 📚 Borrowed Books Section
                  SectionTitle("Borrowed Books"),
                  _borrowedBooks.isEmpty
                      ? const Center(child: Text("No books borrowed."))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _borrowedBooks.length,
                          itemBuilder: (context, index) {
                            return BookCard(
                              book: _borrowedBooks[index],
                              actionLabel: "Return",
                              onPressed: () =>
                                  _returnBook(_borrowedBooks[index]),
                            );
                          },
                        ),

                  const SizedBox(height: 20),

                  // 📚 Available Books Section
                  SectionTitle("Available Books"),
                  _availableBooks.isEmpty
                      ? const Center(child: Text("No books available."))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _availableBooks.length,
                          itemBuilder: (context, index) {
                            return AvailableBookCard(
                              book: _availableBooks[index],
                              onSelect: () =>
                                  _selectReturnDate(_availableBooks[index]),
                            );
                          },
                        ),

                  const SizedBox(height: 20),

                  // 📅 Calendar Section (Shows only if a book is selected)
                  if (_selectedBook != null) ...[
                    SectionTitle(
                        "Select Return Date for ${_selectedBook!.title}"),
                    BorrowCalendar(
                      onDateSelected: (DateTime selectedDate) {
                        setState(() {
                          _selectedReturnDate = selectedDate;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed:
                          (_selectedReturnDate == null) ? null : _borrowBook,
                      child: const Text("Borrow Book"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 📌 Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// 📖 Borrowed Book Card
class BookCard extends StatelessWidget {
  final Book book;
  final String actionLabel;
  final VoidCallback onPressed;

  const BookCard({
    super.key,
    required this.book,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(book.title, style: const TextStyle(fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("By ${book.author}"),
            if (book.borrowDate != null)
              Text(
                "Borrowed on: ${DateFormat('MMM dd, yyyy').format(book.borrowDate!)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            if (book.returnDate != null)
              Text(
                "Return by: ${DateFormat('MMM dd, yyyy').format(book.returnDate!)}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: Text(actionLabel),
        ),
      ),
    );
  }
}

// 📖 Available Book Card
class AvailableBookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onSelect;

  const AvailableBookCard({
    super.key,
    required this.book,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(book.title, style: const TextStyle(fontSize: 16)),
        subtitle: Text("By ${book.author}"),
        trailing: ElevatedButton(
          onPressed: onSelect,
          child: const Text("Select"),
        ),
      ),
    );
  }
}

// 📆 Borrow Calendar (Now Shows 4 Weeks)
class BorrowCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const BorrowCalendar({super.key, required this.onDateSelected});

  @override
  _BorrowCalendarState createState() => _BorrowCalendarState();
}

class _BorrowCalendarState extends State<BorrowCalendar> {
  DateTime? _selectedDate;
  final DateTime _minDate = DateTime.now();
  final DateTime _maxDate = DateTime.now().add(const Duration(days: 28));

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: _minDate,
      lastDay: _maxDate,
      focusedDay: _selectedDate ?? _minDate,
      calendarFormat: CalendarFormat.month, // Ensures full 4-week view
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
        });
        widget.onDateSelected(selectedDay);
      },
    );
  }
}

// 📚 Book Class with Borrow & Return Date
class Book {
  final String title;
  final String author;
  DateTime? borrowDate;
  DateTime? returnDate;

  Book(this.title, this.author);
}
