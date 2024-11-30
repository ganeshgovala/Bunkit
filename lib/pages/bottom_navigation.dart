import 'package:bunkit/pages/home_page.dart';
import 'package:bunkit/pages/login_page.dart';
import 'package:bunkit/pages/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {

    int selectedIndex = 0;
    List<Widget> pages = [HomePage(), ProfilePage()];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_max_outlined), label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: "Profile"),
        ]
      ),
      body: pages[selectedIndex],
    );
  }
}