import 'package:flutter/material.dart';
import 'package:messaging_app/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_info.dart';
import 'user_model.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: Text('Profile'),
      ),
      body: FutureBuilder<UserModel>(
        future: readUser(user.email!),
        builder: (context, snapshot){
          final me = snapshot.data;
          return me == null ? Center( child: Text('Loading...'),)
          :Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(me.profilePic),
                          ),
                        ),
                        Container(
                          width: 220,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                me.name,
                                style:  TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              SizedBox( height: 5,),
                              Text(
                               me.about,
                               maxLines: 3,
                                style:  TextStyle(color: Colors.black, fontSize: 17)
                               )
                            ],
                           ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditInfo() ));
                          },
                          child: Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[400],
                            foregroundColor: Colors.white,
                          ),
                      ),
                    ),
                  )
                ],
              ),

              Divider(height: 1),

              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  'Email: '+user.email!,
                  style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              ),

              Divider(height: 0.5),

              ListTile(
                leading: Icon(Icons.more_time),
                title: Text(
                  'Created at: '+ me.timeCreated.toIso8601String(),
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
          );
        }
      ),
    );
  }
}

Future <UserModel> readUser(String email) async{
  final docuser = FirebaseFirestore.instance.collection('users').doc(email);
  final snapshot = await docuser.get();

  if(snapshot.exists){
    return UserModel.fromJson(snapshot.data()!);
  }
  return UserModel(name: 'Demo', email:'dummy@yo.com', profilePic:'abracadabra', about:'Hello!', timeCreated: DateTime.now(), lastSeen: DateTime.now());
}
