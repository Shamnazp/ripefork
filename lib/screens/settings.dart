import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Theme'),
            onTap: () {
              // Navigate to theme settings
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Push Notifications'),
            onTap: () {
              // Navigate to push notifications settings
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              // Navigate to language settings
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () {
              // Navigate to privacy policy
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About App'),
            onTap: () {
              // Navigate to about app
            },
          ),
          Container(
            padding: const EdgeInsets.all(130.0),
            alignment: Alignment.center,
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
