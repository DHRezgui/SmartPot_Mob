import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final double selectedFontSize;
  final double unselectedFontSize;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.selectedColor = Colors.green,
    this.unselectedColor = Colors.grey,
    this.selectedFontSize = 10,
    this.unselectedFontSize = 10,
  });

  @override
  State<CustomBottomNavBar> createState() => CustomBottomNavBarState();
}

// Notez que j'ai retiré le underscore pour rendre la classe publique
class CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: widget.selectedColor,
      unselectedItemColor: widget.unselectedColor,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/dashboard');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/my_plants');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/account');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'My Plants'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      ],
    );
  }
}
