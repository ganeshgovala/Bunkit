import 'package:bunkit/pages/home_page.dart';
import 'package:bunkit/pages/profile_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List<Widget> pages = [HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selectedIndex,
        showElevation: true,
        iconSize: 26,
        onItemSelected: (index) => setState(() {
          selectedIndex = index;
        }),
        height: 55,
        items: [
            FlashyTabBarItem(
              icon: Icon(
                Icons.home,
                color: const Color.fromARGB(255, 116, 116, 116),
              ),
              title: Text('Home', style: TextStyle(color: const Color.fromARGB(255, 24, 24, 24)),),
            ),
            FlashyTabBarItem(
              icon: Icon(
                Icons.person,
                color: const Color.fromARGB(255, 116, 116, 116),
              ),
              title: Text('Profile', style: TextStyle(color: const Color.fromARGB(255, 24, 24, 24))),
            ),
          ],
      ),
      body: pages[selectedIndex],
    );
  }
}