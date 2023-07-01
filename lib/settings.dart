import 'package:flutter/material.dart';
import 'package:messaging_app/signup.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle notifications settings
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy'),
            onTap: () {
              // Handle privacy settings
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Security'),
            onTap: () {
              // Handle security settings
            },
          ),
          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage() ));
              // Handle logout
            },
          ),
          Divider(height: 0.5),
        ],
      ),
    );
  }
}
