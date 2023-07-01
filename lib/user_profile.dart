import 'package:flutter/material.dart';
import 'package:messaging_app/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Profile'),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.person
            ),
            title: Text(
              'Name:  '+user.displayName!,
              style:  TextStyle(color: Colors.black, fontSize: 17),
            ),

          ),
          Divider(height: 1),

          ListTile(
            leading: Icon(Icons.email),
            title: Text(
              'Email:  '+user.email!,
              style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          ),

          Divider(height: 0.5),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to Settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          Divider(height: 0.5),
        ],
      ),
    );
  }
}

