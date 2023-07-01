import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/google_login.dart';
import 'package:messaging_app/signup.dart';
import 'package:provider/provider.dart';
import 'home.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: MainPage(),
  );
}


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context)=> Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Builder(
              builder: (context) => ChangeNotifierProvider (
                  create: (context) => GoogleSignInProvider(),
                  child: MaterialApp(
                    home: HomePage(),
                  )
              )
          );;
        }
        else {
          return Builder(
              builder: (context) => ChangeNotifierProvider (
                  create: (context) => GoogleSignInProvider(),
                  child: MaterialApp(
                    home: SignUpPage(),
                  )
              )
          );
        }
      },
    ),
  );
}

