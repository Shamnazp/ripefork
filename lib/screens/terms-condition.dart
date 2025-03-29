import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions for RIPEFORK',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Effective Date: 27/03/2025',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'By using the RIPEFORK application, you agree to the following terms and conditions. Please read them carefully.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '1. Use of the App',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '''- You must be at least 13 years old to use this app.
- You agree to use RIPEFORK only for personal and non-commercial purposes.
- You are responsible for maintaining the confidentiality of your account credentials.''',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. User-Generated Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '''- You may submit recipes, reviews, and comments in the app.
- You grant RIPEFORK a non-exclusive, worldwide license to use, modify, and distribute your content.
- You agree not to submit offensive, illegal, or harmful content.''',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '3. Prohibited Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '''- You may not misuse the app, including engaging in hacking, spreading malware, or violating any applicable laws.
- You must not use automated means (e.g., bots, scripts) to access or use the app.''',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '4. Limitation of Liability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '''- RIPEFORK is provided on an "as-is" basis without warranties of any kind.
- We are not responsible for any inaccuracies in recipes or nutritional information.
- We are not liable for any damages resulting from your use of the app.''',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '5. Termination',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- We reserve the right to suspend or terminate your access to RIPEFORK if you violate these terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '6. Changes to Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- We may update these Terms and Conditions from time to time. Continued use of the app means acceptance of the updated terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '7. Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      ),
    );
  }
}
