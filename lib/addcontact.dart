import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String email = _emailController.text;

                    bool ex = await docExists(email);
                    if(ex){
                      await FirebaseFirestore.instance.collection('users').doc(user.email).collection('contacts')
                      .doc(email).set({
                        'name': name,
                        'email': email,
                        'lastContacted': DateTime.now(),
                      });
                    }
                    else{
                      print('Error!');
                    }
                    Navigator.pop(context);
                  }
                },

                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[400],
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> docExists(String email) async{
    DocumentSnapshot<Map<String,dynamic>> document = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(email)
        .get();

    if(document.exists){
      return true;
    } else{
      return false;
    }
  }
}
