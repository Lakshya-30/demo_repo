import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    bool ex = await docExists(googleUser.email);
    if(!ex) await saveUser(googleUser);

    notifyListeners();

  }

  Future logout() async{
    saveLastSeen();
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<void> saveUser(GoogleSignInAccount googleUser) async{
    await FirebaseFirestore.instance.collection("users")
        .doc(googleUser.email)
        .set({
          "email" : googleUser.email,
          "name" : googleUser.displayName,
          "profilePic" : googleUser.photoUrl,
          'timeCreated': DateTime.now(),
          'lastSeen': DateTime.now(),
          "about" : "Hi! I love the messaging app",
        });
  }

  Future saveLastSeen() async{
    await FirebaseFirestore.instance.collection("users")
        .doc(user.email)
        .update({
      "lastSeen" : DateTime.now(),
    });
  }

  Future<bool> docExists(String email) async{
    DocumentSnapshot <Map<String,dynamic>> document = await FirebaseFirestore
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