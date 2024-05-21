import 'package:basic_crud_application/views/main_screens/subscreens/account_screen.dart';
import 'package:basic_crud_application/views/main_screens/subscreens/students_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _pageIndex = 0;
  final List<Widget> _page = [
    const StudentsScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          backgroundColor: Colors.white,
          onTap: (value) => {
                setState(() {
                  _pageIndex = value;
                }),
              },
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.greenAccent.shade700,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: 'Students'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
          ]),
      body: _page[_pageIndex],
    );
  }
}
