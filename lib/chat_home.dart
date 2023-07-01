import 'package:flutter/material.dart';
import 'package:messaging_app/contact_page.dart';

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
      body: Center(
        child: Text('Chat Home Page'),
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
