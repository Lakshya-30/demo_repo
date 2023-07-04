import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/contact_page.dart';

import 'contact_profile.dart';
import 'messaging_page.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text(
          'ChatMe',
          style: TextStyle(letterSpacing: 1),
        ),
        actions: [
          IconButton(onPressed: () {},
            icon: Icon(Icons.search),),
        ],
        bottom: TabBar(
          tabs: [
            Tab(text: 'Allchats'),
            Tab(text: 'Personal'),
            Tab(text: 'Work'),
            Tab(text: 'Groups'),

          ],),
      ),
      body: Column(
        children: [
          Expanded(child: RecentList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage() ));
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.deepPurple[400],


      ),
    );
  }
}

class RecentList extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user.email).collection('contacts').orderBy('lastContacted',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('Loading...'));
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
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.deepPurple[400]!),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagePage(
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