import 'package:flutter/material.dart';
import 'package:messaging_app/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:messaging_app/google_login.dart';
import 'package:messaging_app/chat_home.dart';
import 'package:messaging_app/status_home.dart';
import 'package:messaging_app/calls_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex =0;
  final screens = [
    ChatHomePage(),
    StatusHomePage(),
    CallHomePage(),
    UserProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4,child: Scaffold(
      body: screens[_currentIndex ],


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 17,
        selectedItemColor: Colors.deepPurple[400],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Chat',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled_rounded),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_call),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
        setState(() { _currentIndex = index; });
        },
      ) ,
      ),
    );
  }
}
