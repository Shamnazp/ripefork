import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/screens/settings/settings_tile.dart';
import 'package:ripefo/screens/settings/version_info.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          buildSettingsTiles(context),
          const VersionInfo(),
        ],
      ),
    );
  }
}
