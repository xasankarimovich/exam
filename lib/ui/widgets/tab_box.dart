import 'package:flutter/material.dart';
import '../screen/home_screen.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({super.key});

  @override
  _TabBoxScreenState createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    Center(child: Text('1')),
    Center(child: Text('2')),
    ExpenseScreen(),
    Center(child: Text('4')),
    Center(child: Text('5')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_work,
              color: Colors.grey,
            ),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fact_check_outlined,
              color: Colors.grey,
            ),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.grey,
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            label: 'Tab 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
