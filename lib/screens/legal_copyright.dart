import 'package:flutter/material.dart';

class LegalCopyrightScreen extends StatelessWidget {
  const LegalCopyrightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal & Copyright'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Legal & Copyright Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              const Text(
                'Copyright © 2025 RIPEFORK. All Rights Reserved.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              const Text(
                'Intellectual Property Rights',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              const Text(
                'All content, including text, graphics, logos, and images, within the RIPEFORK app is the property of RIPEFORK or its licensors and is protected under copyright and trademark laws. '
                'Unauthorized reproduction, modification, distribution, or exploitation of any content without prior written consent is strictly prohibited.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              const Text(
                'License to Use the App',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              const Text(
                'RIPEFORK grants users a limited, non-exclusive, non-transferable license to use the application for personal, non-commercial purposes. '
                'You may not modify, reverse-engineer, or resell any part of the app without permission.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              const Text(
                'User Responsibilities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              const Text(
                '- You agree not to misuse the app in any way that violates laws or regulations.\n'
                '- You are responsible for any content you upload, ensuring it does not infringe on third-party copyrights.\n'
                '- Any violation of these terms may result in the suspension or termination of your access to the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              const Text(
                'Third-Party Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              const Text(
                'Some recipes, images, or content in the RIPEFORK app may be sourced from third parties. '
                'All rights belong to their respective owners, and such content is used with permission or under fair use guidelines.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              const Text(
                'Disclaimer of Liability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              const Text(
                'RIPEFORK provides the app on an "as-is" basis without warranties of any kind. '
                'We are not responsible for any inaccuracies, damages, or losses resulting from the use of the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              const Text(
                'Changes to Legal Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              const Text(
                'We reserve the right to update or modify these legal terms at any time. '
                'Users will be notified of any significant changes via the app or email.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('shamnaz@gmail.com'),
              onTap: () {
                // Implement email sending functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: const Text('Address'),
              subtitle: const Text('Hustle Hub Tech Park, Bangalore'),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
