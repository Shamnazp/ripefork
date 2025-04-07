import 'package:flutter/material.dart';
import 'package:ripefo/screens/add_recipe.dart';
import 'package:ripefo/screens/home.dart';
import 'package:ripefo/screens/login.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/search_recipe.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'lib/assets/OnBoarding.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // // Skip Button
          // Positioned(
          //   top: 40,
          //   right: 20,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       print('skip');
          //       // Navigator.pushReplacement(
          //       //   context,
          //       //   MaterialPageRoute(builder: (context) => LoginScreen()));
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.grey[200],
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     child: const Text(
          //       'Skip',
          //       style: TextStyle(
          //         color: Colors.black, // Changed text color to black
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),

          // Text Overlay
          Positioned(
            bottom: 230, // Adjust as needed
            left: 30,
            right: 30,
            child: Column(
              children: [
                Text(
                  "Let's ",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.yellow,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Cooking",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Find best recipes for cooking...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Start Cooking Button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(email: '',),
                    ),
                  );
                  print("start cooking...");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Start Cooking",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}