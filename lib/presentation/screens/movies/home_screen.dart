import 'package:flutter/material.dart';
import 'package:movie_app/presentation/views/views.dart';
import 'package:movie_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String name = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeView(),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
