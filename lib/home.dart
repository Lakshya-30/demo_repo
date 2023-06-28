import 'package:flutter/material.dart';
import 'package:messaging_app/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:messaging_app/google_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        leading: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage())
            ),
            icon: Icon(Icons.account_circle_rounded),
        ),
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final provider = Provider.of<GoogleSignInProvider>(context, listen:false);
                provider.logout();
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      backgroundColor: Colors.black87,

      body: Column(

      ),
    );
  }
}
