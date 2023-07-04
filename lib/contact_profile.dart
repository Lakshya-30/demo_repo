import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/settings.dart';
import 'package:messaging_app/user_model.dart';

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
      body: FutureBuilder(
        future: getContact(contact.email),
        builder: (context, snapshot){
        final you = snapshot.data;
        return you == null ? Center( child: Text('Loading...'),)
        : Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.ce,
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(you.profilePic),
                radius: 60,
              ),
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

              ListTile(
                leading: Icon(Icons.access_time),
                title: Text(
                  'Last Seen: ${you.lastSeen}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),

              Divider(height: 0.5),

              ListTile(
                leading: Icon(Icons.edit),
                title: Text(
                  'About: ${you.about}',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),

              Divider(height: 0.5),


            ],
          ),
        );
        }
      ),
    );
  }
}
class Contact {
  final String id;
  final String name;
  final String email;
  final Timestamp lastContacted;

  Contact({required this.id, required this.name, required this.email, required this.lastContacted});

  factory Contact.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Contact(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      lastContacted: data['lastContacted'],
    );
  }
}

Future <UserModel> getContact(String email) async{
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);
  final snapshot = await docUser.get();

  if(snapshot.exists){
    return UserModel.fromJson(snapshot.data()!);
  }
  return UserModel(name: 'Demo', email:'dummy@yo.com', profilePic:'abracadabra', about:'Hello!', timeCreated: DateTime.now(), lastSeen: DateTime.now());
}