  import 'package:flutter/material.dart';
  import 'package:stock_taking_application/view/setting_screen/setting_screen.dart';
  import '../resources/constants/app_Colors.dart';
  import 'home_screen/home_screen.dart';


  class MainScreen extends StatefulWidget {
    const MainScreen({super.key});

    @override
    State<MainScreen> createState() => _MainScreenState();
  }

  class _MainScreenState extends State<MainScreen> {
    int _currentIndex = 0;

    final List<Widget> _pages = [
      const HomePage(),
      const SettingsScreen(),
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              activeIcon:  Icon(Icons.home,color: AppColors.primaryColor,),
              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon:  Icon(Icons.settings,color: AppColors.primaryColor,),
              label: 'Settings',
            ),
          ],
        ),
      );
    }
  }
