import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assets/RipeFork.png'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Mission',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'At RIPEFORK, we are dedicated to generate and provide the best recipes for your needs and cravings. Our goal is to make you eat good food with delicious recipes all over the world and we are grateful for the customers who are happy to use this application.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Story',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Founded in 2025, RIPEFORK started with a vision to Bring joy and cook delicious food and provide every recipes for the customers. ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('contact@ripefork.com'),
              onTap: () {
                // Implement email sending functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: const Text('+91 8078199781'),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Website'),
              subtitle: const Text('www.ripefork.com'),
              onTap: () {
                // Implement website opening functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}