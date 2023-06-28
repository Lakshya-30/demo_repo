import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    //DocumentSnapshot<Map<String, dynamic>> snapshot = FirebaseFirestore.instance.collection('users').doc(user.email).snapshots();
    //final data = snapshot.data();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple[400],
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            SizedBox(height: 20,),
            Text(
              'Name:  '+user.displayName!,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20,),
            Text(
              'Email:  '+user.email!,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20,),
            Text(
              'Created at:  still working on this',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
