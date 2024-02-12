import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.childView,
  });

  final Widget childView;

  static String name = "home-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
