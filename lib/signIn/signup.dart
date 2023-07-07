import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/signIn/google_login.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white70,
    appBar: AppBar(
      title: Text('Signup'),
      backgroundColor: Colors.deepPurple[400],
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: Image(
              image: NetworkImage('https://img.icons8.com/?size=512&id=kPY3a3dWiniG&format=png'),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text('Welcome!',style: TextStyle( color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold), ),
          SizedBox(height: 20,),
          Text('Please login Using your Google account', style: TextStyle(color: Colors.black),),
          SizedBox(
            height: 100,
          ),
          ElevatedButton.icon(
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
            label: Text('Sign Up with Google'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple[400],
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.amberAccent),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    ),
  );
}