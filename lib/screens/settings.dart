import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripefo/screens/about_us.dart';
import 'package:ripefo/screens/feedback.dart';
import 'package:ripefo/screens/help_support.dart';
import 'package:ripefo/screens/legal_copyright.dart';
import 'package:ripefo/screens/privacy_policy.dart';
import 'package:ripefo/screens/terms-condition.dart';

class SettingsScreen extends StatelessWidget {
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
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About App'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpSupportScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.gavel),
            title: Text('Legal & Copyright'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LegalCopyrightScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Terms & Conditions'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionsScreen()));
            }, 
          ),
          // ListTile(
          //   leading: Icon(Icons.feedback_rounded),
          //   title: Text(
          //     'Feedback',
              
          //   ),
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackScreen()));
          //   },
            
          // ),
          Container(
            padding: const EdgeInsets.all(20.0),
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
