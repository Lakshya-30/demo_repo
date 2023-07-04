import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/addcontact.dart';
import 'package:messaging_app/contact_profile.dart';

final user = FirebaseAuth.instance.currentUser!;

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Contacts'),

      ),
      body: Column(
        children: [
          ContactCount(),
          Expanded(child: ContactList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage()),
          );

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple[400],
      ),
    );
  }
}

class ContactList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user.email).collection('contacts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No contacts found'));
        }

        List<Contact> contacts = snapshot.data!.docs
            .map((doc) => Contact.fromSnapshot(doc))
            .toList();

        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].email),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.email)
                      .collection('contacts')
                      .doc(contacts[index].id)
                      .delete();
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactProfilePage(
                      contact: contacts[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class ContactCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user.email).collection('contacts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }

        int count = snapshot.data!.docs.length;

        return Text('Total contacts: $count');
      },
    );
  }
}







