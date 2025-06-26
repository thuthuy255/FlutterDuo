import 'package:duolingo/home/screen/home_screen.dart';
import 'package:duolingo/home/screen/missionbadge_screen.dart';
import 'package:duolingo/home/screen/notification_screen.dart';
import 'package:duolingo/home/screen/ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/tabbar/my_tabbar.dart';

// Provider cho trạng thái refresh
class RefreshProvider with ChangeNotifier {
  bool isRefresh = false;

  void setIsRefresh(bool value) {
    isRefresh = value;
    notifyListeners();
  }
}

class MainTabNavigation extends StatefulWidget {
  const MainTabNavigation({super.key});

  @override
  State<MainTabNavigation> createState() => _MainTabNavigationState();
}

class _MainTabNavigationState extends State<MainTabNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen(),
    NotificationScreen(),
    RankingScreen(),
    MissionBadgeScreen(),
  ];

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RefreshProvider(),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: MyTabBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
