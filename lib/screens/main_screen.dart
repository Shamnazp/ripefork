import 'package:flutter/material.dart';
import 'package:ripefo/screens/home/home_screen.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/search_recipe/search_recipe_screen.dart';
import 'package:ripefo/screens/add_recipe/add_recipe_screen.dart';
import 'package:ripefo/screens/saved_recipes/saved_recipes_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(email: '',),
    SearchRecipeScreen(),
    AddRecipeScreen(),
    SavedRecipesScreen(),
    ProfileScreen(email: ''), // Update email logic if needed
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
