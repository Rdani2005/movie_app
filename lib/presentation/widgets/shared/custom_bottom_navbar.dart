import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/views/views.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favorites",
        ),
      ],
    );
  }
}
