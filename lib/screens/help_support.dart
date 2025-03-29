import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Support',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to the Help & Support section. Here you will find answers to common questions and ways to reach our support team.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Frequently Asked Questions (FAQs)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. How can I see my last viewed recipes?\n'
                '   - The search screen automatically displays the last three recipes you viewed.\n'
                '\n'
                '2. How do I add a new recipe to the app?\n'
                '''  - Tap on the "Add Recipe" button.

  - Enter the required details, such as the recipe name, ingredients, and instructions.

  - Press the "Add Recipe" button to save your recipe.

  - Once added, your recipe will appear in the "Added Recipes" section on the search screen.\n'''
                '\n'
                '3. How do I save my favorite recipes?\n'
                '   - Click on the heart icon on any recipe to save it to your favorites list.\n'
                '\n'
                '4. How do I contact customer support?\n'
                '   - You can reach out to us via email or visit our office.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'If you need further assistance, please contact us through the following methods:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('shamnaz@gmail.com'),
              
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: const Text('Address'),
              subtitle: const Text('Hustle Hub Tech Park, Bangalore'),
              
            ),
              SizedBox(height: 16),
              Text(
                'Feedback',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'We value your feedback! Let us know how we can improve by sending your suggestions to feedback@ripefork.com.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
