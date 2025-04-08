import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/screens/add_recipe/add_recipe_screen.dart';
import 'package:ripefo/screens/profile.dart';
import 'package:ripefo/screens/saved_recipes/saved_recipes_screen.dart';
import 'package:ripefo/screens/search_recipe/search_recipe_screen.dart';
import 'package:ripefo/screens/settings/settings_screen.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: userProvider
                                    .profileImage.isNotEmpty
                                ? FileImage(File(userProvider.profileImage))
                                    as ImageProvider
                                : const AssetImage('assets/default_user.png'),
                            child: userProvider.profileImage.isEmpty
                                ? const Icon(Icons.person,
                                    size: 20, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddRecipeScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Hey there, 👋\n${userProvider.name}',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      );
      },
    );
  }
}
