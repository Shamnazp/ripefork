import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ripefo/providers/user_provider.dart';
import 'package:ripefo/screens/manage_profile.dart';
import 'package:ripefo/screens/saved_recipe.dart';
import 'package:ripefo/screens/settings.dart';


class ProfileScreen extends StatelessWidget {
  final String email;
  const ProfileScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    //retrieves user details
    final userProvider = Provider.of<UserProvider>(context); // Get user data
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black87),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SavedRecipesScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Profile Section
            Consumer<UserProvider>(
              //widget lekk vilikknnond
              builder: (context, userProvider, child) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor:
                          Colors.grey[300], 
                      backgroundImage: userProvider.profileImage.isNotEmpty
                          ? FileImage(File(userProvider.profileImage))
                              as ImageProvider
                          : null,
                      // profile empty aaumbo image background grey aavan
                      child: userProvider.profileImage.isEmpty
                          ? const Icon(Icons.person,
                              size: 40,
                              color: Colors.white) 
                          : null, // image indel icon kaanand nikkan
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.name, // Get name from Provider
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          userProvider.email, // Get email from Provider
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 15),
            // Manage Profile Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManageProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE5B4),
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  "Manage profile",
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
