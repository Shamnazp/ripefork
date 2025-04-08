import 'package:flutter/material.dart';
import 'package:ripefo/screens/settings/about_us.dart';
import 'package:ripefo/screens/settings/help_support.dart';
import 'package:ripefo/screens/settings/privacy_policy.dart';
import 'package:ripefo/screens/settings/legal_copyright.dart';
import 'package:ripefo/screens/settings/terms-condition.dart';

Widget buildSettingsTiles(BuildContext context) {
  return Column(
    children: [
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text('About App'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Help & Support'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.privacy_tip),
        title: const Text('Privacy Policy'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.gavel),
        title: const Text('Legal & Copyright'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LegalCopyrightScreen()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.description),
        title: const Text('Terms & Conditions'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()));
        },
      ),
    ],
  );
}
