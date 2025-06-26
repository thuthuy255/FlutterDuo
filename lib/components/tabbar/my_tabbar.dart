import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyTabBar({super.key, required this.currentIndex, required this.onTap});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant MyTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.currentIndex;
      });
    }
  }

  void _handleTap(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final layout = MediaQuery.of(context).size;

    return Container(
      height: layout.height * 0.1,
      color: Colors.white,
      child: Row(
        children: List.generate(4, (index) {
          final isFocused = _selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => _handleTap(index),
              child: Center(
                child: Container(
                  width: layout.width * 0.13,
                  height: layout.width * 0.13,
                  decoration: BoxDecoration(
                    color: isFocused ? const Color(0xFFE6F4FF) : Colors.white,
                    borderRadius: BorderRadius.circular(layout.width * 0.04),
                    border: Border.all(
                      color: const Color(0xFF9CD8FF),
                      width: layout.width * 0.006,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      _getTabIconPath(index),
                      fit: BoxFit.contain,
                      width: layout.width * 0.07,
                      height: layout.width * 0.07,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _getTabIconPath(int index) {
    switch (index) {
      case 0:
        return 'assets/icons/Home.png';
      case 1:
        return 'assets/icons/ring.png';
      case 2:
        return 'assets/icons/cup.png';
      case 3:
        return 'assets/icons/ruong.png';
      default:
        return 'assets/icons/Home.png';
    }
  }
}
