import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/contacts/addcontact.dart';
import 'package:messaging_app/contacts/contact_profile.dart';
import 'package:messaging_app/messaging_page.dart';

final user = FirebaseAuth.instance.currentUser!;
class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  User user = FirebaseAuth.instance.currentUser!;
  void refresh() async{
    await user.reload();
  user = FirebaseAuth.instance.currentUser!;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Contact'),
            ContactCount(),
          ],
        ),

      ),
      body: Column(
        children: [
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


  Future<void> deleteContact(String contactId) async {
  try {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('contacts')
      .doc(contactId)
      .delete();
  } catch (e) {
  print('Failed to delete contact: $e');
  }
  }

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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Contact'),
                      content: Text('Are you sure you want to delete this contact?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            deleteContact(contacts[index].id);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
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

        return Text(' $count contacts',
          style: TextStyle(fontSize: 15,),
        );
      },
    );
  }
}







