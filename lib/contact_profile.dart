import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/settings.dart';

class ContactProfilePage extends StatelessWidget {
  final Contact contact;

  ContactProfilePage({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Contact Profile'),

        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.person
            ),
            title: Text(
                'Name: ${contact.name}',
              style:  TextStyle(color: Colors.black, fontSize: 17),
            ),

          ),
          Divider(height: 1),

          ListTile(
            leading: Icon(Icons.email),
            title: Text(
            'Email: ${contact.email}',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),

          Divider(height: 0.5),


        ],
      ),
    );
  }
}
class Contact {
  final String id;
  final String name;
  final String email;

  Contact({required this.id, required this.name, required this.email});

  factory Contact.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Contact(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
    );
  }
}