import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_mentor/InterestPage.dart';
import 'LessonsPage.dart';
import 'HomePage.dart';
import 'ScorecardPage.dart';
import 'SpendingPage.dart';

const Color buttonColor = Colors.teal;
const Color buttonText = Colors.white;
const Color backgroundColor = Color.fromARGB(255, 58, 58, 60);

const String score = '50';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        //scaffoldBackgroundColor: Colors.transparent,
      ),
      routes: {
        "/": (context) => const MainPage(),
        "/score": (context) => ScorecardPage(score: score)
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;
  var pages = {
    0: SpendingPage(),
    1: ScorecardPage(score: '123'),
    2: const HomePage(),
    3: const LessonsPage(),
    4: InterestPage(),
  };
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomCurvedNavigationBar(
        buttonColor: buttonColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomCurvedNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final Color buttonColor;

  const CustomCurvedNavigationBar({
    super.key,
    required this.onTap,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      color: buttonColor,
      items: const <Widget>[
        Icon(Icons.money, size: 30, color: Colors.white),
        Icon(Icons.pie_chart, size: 30, color: Colors.white),
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.school, size: 30, color: Colors.white),
        Icon(Icons.line_axis, size: 30, color: Colors.white),
      ],
      index: 2,
      onTap: onTap,
    );
  }
}
