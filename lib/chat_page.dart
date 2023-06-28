import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/contact_profile.dart';
import 'package:messaging_app/typing_msg.dart';

import 'chat_list.dart';

class ChatScreen extends StatelessWidget {
  final Contact contact;
  //final Map<String, dynamic> userMap;
  ChatScreen({super.key, required this.contact});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.deepPurple[400],
         title: Container(
           child: Column(
             children: [
               Text(contact.name),

             ],
           )
         ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ContactProfilePage(
                        contact: contact),
                    )
                );
              },
              icon: const Icon(Icons.account_circle)
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )

        ],
      ),
      body : Stack(
        children :[
          Column(
            children : [
              Expanded(
                  child: chatList(),
              ),
              Container(height: 52),
              TypingMsg(recieverUserId:contact.email),
            ]
          )
        ]
      )
    );
  }
}
